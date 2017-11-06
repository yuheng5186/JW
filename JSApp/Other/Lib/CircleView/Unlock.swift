import UIKit
// MARK: - 存储属性及初始化
class Unlock: UIView {
    var state: UnlockState = UnlockState.normal{
        didSet{
            setNeedsDisplay()
        }
    }
    var circles = [Circle]()
    var touchedCircles = [Circle]()
    var curPoint: CGPoint = CGPoint.zero
    var result: ((String)->Void)?
    
    convenience init() {
        self.init(frame: CommonConfig.Unlock.frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        perpare(frame)
        backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
// MARK: - 初始化时布局下9个圈圈，无需layoutSubviews
extension Unlock{
    fileprivate func perpare(_ rect: CGRect){
        let circleRadius = rect.size.width / 3.0 * CommonConfig.Unlock.circleRadiusRadio
        let circleMargin = rect.size.width / 3.0 - circleRadius
        for row in 0..<3{
            for col in 0..<3{
                let x = CGFloat(row) * (circleMargin + circleRadius) + circleMargin / 2.0
                let y = CGFloat(col) * (circleMargin + circleRadius) + circleMargin / 2.0
                let frame = CGRect(x: x, y: y, width: circleRadius, height: circleRadius)
                let circle = Circle(row: row, col: col, frame: frame)
                addSubview(circle)
                circles.append(circle)
            }
        }
    }
}
// MARK: - touch 绘图
extension Unlock{
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        // 裁剪时候要用到
        ctx!.addRect(rect)
        
        circles.forEach { (circle) -> () in
            ctx!.addEllipse(in: circle.frame)
        }
        ctx?.clip()
        
        //        CGContextEOClip(ctx!)
        // 裁剪代码
        var first = true
        for circle in touchedCircles {
            if first {
                ctx!.move(to: CGPoint(x: circle.center.x, y: circle.center.y))
                first = false
            } else {
                ctx!.addLine(to: CGPoint(x: circle.center.x, y: circle.center.y))
            }
        }
        if touchedCircles.count > 0 && curPoint != CGPoint.zero {
            ctx!.addLine(to: CGPoint(x: curPoint.x, y: curPoint.y))
        }
        //线条转角样式,只有线粗的时候第一个有点用，第二个是转角但是转角其实被掩盖了，暂且留着
        ctx!.setLineCap(CGLineCap.round);
        ctx!.setLineJoin(CGLineJoin.round);
        // 设置绘图的属性
        ctx!.setLineWidth(CommonConfig.Unlock.edgeWidthRadio * rect.size.width)
        // 线条颜色
        state.getColor().set()
        //渲染路径
        ctx!.strokePath();
    }
}
// MARK: - touch 触摸过程
extension Unlock{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = touches.first!.location(in: self)
        curPoint = point
        for circle in circles {
            if circle.frame.contains(point) { //应当判断点是否在圆内，但是这个只是个矩形，暂且如此
                circle.state = CircleState.lSelected
                touchedCircles.append(circle)
                break
            }
        }
        setNeedsDisplay()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        curPoint = point
        for circle in circles {
            // 包含在某圆内，但是不在已选中的内
            if circle.frame.contains(point) && !touchedCircles.contains(circle) { //应当判断点是否在圆内，但是这个只是个矩形，暂且如此
                if touchedCircles.count > 0{
                    // 设置方向
                    let preCircle = touchedCircles.last!
                    preCircle.setAagle(circle)
                    preCircle.state = CircleState.selected
                    // 处理跳的情况，判断只适用于一跳的情况，当然九宫格只有一跳
                    let lhs = abs(preCircle.col - circle.col)
                    let rhs = abs(preCircle.row - circle.row)
                    if (lhs + rhs) % 2 == 0 && (lhs == 2 || rhs == 2) {
                        let midRow = (preCircle.row + circle.row) / 2
                        let midCol = (preCircle.col + circle.col) / 2
                        let midCircle = circles[midRow * 3 + midCol]
                        if !touchedCircles.contains(midCircle) { //注意是没有选过的
                            print(circle)
                            midCircle.setAagle(circle)
                            midCircle.state = CircleState.selected
                            touchedCircles.append(midCircle)
                        }
                    }
                }
                circle.state = CircleState.lSelected
                touchedCircles.append(circle)
                break
            }
        }
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        curPoint = CGPoint.zero
        self.setNeedsDisplay()
        let ret = touchedCircles.reduce(""){ $0 + String($1.row * 3 + $1.col) }
        print(ret)
        result?(ret)
    }
}
// MARK: - 对外接口
extension Unlock{
    /**
     若返回结果错误，显示错误颜色，并displayTime后绘图消失
     
     - parameter displayTime: 消失时间
     */
    func processWrong(_ displayTime: UInt64 = 600){
        
        state = UnlockState.error // 变线的颜色
        for circle in touchedCircles {
            switch circle.state {
            case .selected:
                circle.state = .error
            case .lSelected:
                circle.state = .lError
            default:
                break
            }
        }
        processRight(displayTime)
    }
    /**
     若返回结果错误，显示正确颜色，并displayTime后绘图消失
     
     - parameter displayTime: 消失时间
     */
    func processRight(_ displayTime: UInt64 = 600){
        let time = DispatchTime.now() + Double((Int64)(displayTime * NSEC_PER_MSEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.processClear()
        }
    }
    /**
     判定成功，不做等待，立即消失
     */
    func processClear(){
        touchedCircles.forEach { (circle) -> () in
            circle.state = CircleState.normal
        }
        touchedCircles.removeAll(keepingCapacity: false)
        state = UnlockState.normal
    }
}
