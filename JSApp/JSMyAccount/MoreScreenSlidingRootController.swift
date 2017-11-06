//
//  MoreScreenSlidingRootController.swift
//  JSApp
//
//  Created by user on 16/7/21.
//  bb
//

import UIKit

class MoreScreenSlidingRootController: BaseViewController,UIScrollViewDelegate {
    
    var bgScrollView: UIScrollView!                //滑动视图
    var lineView: UIView?                       //移动的线条
    var btnArray: [UIButton] = []                  //装button的数组
    var buttonTitleArray:[String]?              //3个按钮的title数组
    var isTouch:Bool! = false                   //判断是否点击

    var invalidCouponBtn: UIButton!  //查看失效优惠券
    let couponType = [2,3,4]                    //优惠券  2=返现券 3=加息券 4=翻倍券
    var isFromMyAccount:Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (navigationController?.navigationBar.isHidden)! {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func backAction() {
        let vc = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constantSet()
        createUI()
        
        if isFromMyAccount == 1 {
            self.popType = .reloadApp
        }
        //去投资
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "去投资", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MoreScreenSlidingRootController.goInvest))
    }

    //MARK: - 去投资
    func goInvest()
    {
        RootNavigationController.goToInvestList(controller: self)
    }

    
    /**
     常量的设置
     */
    func constantSet() {
        buttonTitleArray = ["返现红包","加息券"]
        navigationItem.title = "优惠券"
    }
    
    //按钮点击action
    func buttonClickAction() -> () {
        let controller = JSCouponExplainViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /**
     界面的创建
     */
    func createUI() {
        
        self.view.backgroundColor = DEFAULT_GRAYCOLOR
        
        let btnWidth = SCREEN_WIDTH / CGFloat((buttonTitleArray?.count)!)
        var btnHeight:CGFloat = 0.00
        btnHeight = 40
        for i in 0...buttonTitleArray!.count - 1{
                let btn = UIButton(frame: CGRect( x: CGFloat(i) *  btnWidth, y: 0, width: SCREEN_WIDTH / CGFloat(buttonTitleArray!.count), height: btnHeight))
                btn.backgroundColor = UIColor.white
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.setTitleColor(DEFAULT_DARKGRAYCOLOR, for: UIControlState())
                
                btn.setTitle(buttonTitleArray![i], for: UIControlState())
                btn.tag = 100 + i
                btn.addTarget(self, action: #selector(MoreScreenSlidingRootController.btnClick(_:)), for: UIControlEvents.touchUpInside)
                self.view.addSubview(btn)
                btnArray.append(btn)
        }
        
        //移动的线条
        lineView = UIView (frame: CGRect(x: 0, y: btnHeight , width: btnWidth,height: 2))
        lineView!.backgroundColor = UIColor.clear
        self.view.addSubview(lineView!)
        
        let line = UIView(frame:CGRect(x: btnWidth / 4, y: 0, width: btnWidth / 2, height: 2))
        line.backgroundColor = DEFAULT_GREENCOLOR
        lineView!.addSubview(line)
        bgScrollView = UIScrollView(frame: CGRect(x: 0, y: btnHeight + 2 + 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - btnHeight - 2 - TOP_HEIGHT))
        bgScrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat((buttonTitleArray?.count)!), height: bgScrollView!.frame.size.height)
        bgScrollView.delegate = self
        bgScrollView.backgroundColor = DEFAULT_GRAYCOLOR
        bgScrollView.isPagingEnabled = true
        self.view.addSubview(bgScrollView!)
        
        for i in 0 ..< 2 {
            let vc = JSCouponViewController()
            self.addChildViewController(vc)
            vc.view.frame = CGRect(x: bgScrollView.frame.size.width * CGFloat(i), y: 0, width: bgScrollView.frame.size.width, height: ((bgScrollView?.frame.size.height)! - 70))
            vc.view.backgroundColor = DEFAULT_GRAYCOLOR
            self.bgScrollView?.addSubview(vc.view)
            vc.couponType = couponType[i]
            
            let invalidCouponBtn = UIButton(frame: CGRect(x: bgScrollView.frame.size.width * CGFloat(i), y: vc.view.height + vc.view.y + 5, width: SCREEN_WIDTH, height: 45))
            invalidCouponBtn.setTitle("失效优惠券", for: UIControlState())
            invalidCouponBtn.setTitleColor(UIColorFromRGB(21, green: 21, blue: 21), for: UIControlState())
            invalidCouponBtn.backgroundColor = UIColor.white
            invalidCouponBtn.addTarget(self, action: #selector(MoreScreenSlidingRootController.invalidCouponClick(_:)), for: .touchUpInside)
            bgScrollView.addSubview(invalidCouponBtn)

        }
        self.navigationItem.rightBarButtonItem = nil
    }
    
    //MARK: - 查看失效优惠券
    func invalidCouponClick(_ sender:UIButton)
    {
        print("点击查看失效券")
        let validCouponVC = JSInvalidCouponViewController()
        self.navigationController?.pushViewController(validCouponVC, animated: true)
    }
    
    
    /*
     button 点击事件
     */
    func btnClick(_ button:UIButton) {
        self.isTouch = true
        let newFrame = CGRect( x: CGFloat((button.tag - 100)) * SCREEN_WIDTH / CGFloat(btnArray.count), y: button.frame.size.height, width: SCREEN_WIDTH / CGFloat(btnArray.count), height: 2)
        UIView.animate(withDuration: 0.3, animations: {
            self.lineView?.frame = newFrame
        }, completion: { (finished:Bool) -> Void in
            self.isTouch = false
        }) 
        bgScrollView?.setContentOffset(CGPoint( x: CGFloat((button.tag - 100)) * SCREEN_WIDTH, y: 0), animated: true)
    }
    /*
     scrollview代理
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isTouch {
            var newFrame = self.lineView?.frame
            newFrame?.origin.x = scrollView.contentOffset.x / CGFloat( (buttonTitleArray?.count)!)
            self.lineView?.frame = newFrame!
        }
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){
        
        if !isTouch {
            var newFrame = self.lineView?.frame
            newFrame?.origin.x = scrollView.contentOffset.x / CGFloat((buttonTitleArray?.count)!)
            self.lineView?.frame = newFrame!
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.btnClick(btnArray[Int(scrollView.contentOffset.x / SCREEN_WIDTH)])
    }
    
}
