//
//  JSChooseView.swift
//  JSApp
//
//  Created by 一言难尽 on 2017/3/31.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSChooseViewSencond: UIView {

    @IBOutlet weak var leftTitleLabel_1: UILabel! //左边label
    @IBOutlet weak var titleLabel_1: UILabel!
    @IBOutlet weak var bottomViewHeightConstains: NSLayoutConstraint!
    
    //底部按钮
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var bottomView: UIView!

    var rightBottomButtonCallback: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bottomButton.layer.cornerRadius = 4
        self.bottomButton.layer.masksToBounds = true

        self.backgroundColor = PopView_BackgroundColor        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureCloseAction)))
    }
    
    //点击空白取消
    func gestureCloseAction(getrue: UITapGestureRecognizer) {
        
        let point: CGPoint = getrue.location(in: self)
        
        let minY = self.bottomView.frame.minY
        
        if point.y < minY {
            JSChooseViewSencond.animateRemoveFromSuperView(chooseView: self,
                                                    animate: true)
        }
    }
    
    /**
     * 选择视图初始化(动画般从下向上推出)
     * status: 0：表示存管和平台账户都存在,1：表示只有存管账户，2：只有平台账户
     */
    class func animateWindowsAddSubView(status: Int) -> JSChooseViewSencond {
        
        //创建pushView
        let chooseView = Bundle.main.loadNibNamed("JSChooseViewSencond", owner: self, options: nil)?.last as? JSChooseViewSencond
        
        let chooseViewHeight: CGFloat = 220
        
        chooseView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        chooseView!.bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: chooseViewHeight)
        chooseView?.bottomViewHeightConstains.constant = chooseViewHeight
        
        UIApplication.shared.keyWindow?.addSubview(chooseView!)
        
        //动画般显示pushView
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            chooseView!.bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT - chooseViewHeight, width: SCREEN_WIDTH, height: chooseViewHeight)
        }) { finished -> () in
        }
        
        return chooseView!
    }
    
    /**
     *  选择视图初始化(动画般从上向下移除)
     *  status: 0：表示存管和平台账户都存在,1：表示只有存管账户，2：只有平台账户
     */
    class func animateRemoveFromSuperView(chooseView: JSChooseViewSencond,
                                          animate: Bool) {
        
        let chooseViewHeight: CGFloat = 220
        
        if animate == true {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                chooseView.bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: chooseViewHeight)
            }) { finished ->() in
                chooseView.removeFromSuperview()
            }
            
        } else {
            chooseView.removeFromSuperview()
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        MobClick.event("0300003")
        JSChooseViewSencond.animateRemoveFromSuperView(chooseView: self,
                                                animate: true)
    }
    
    //底部下一步按钮点击事件
    @IBAction func bottomButtonClick(_ sender: Any) {
        
        JSChooseViewSencond.animateRemoveFromSuperView(chooseView: self, animate: false)
        
        if self.rightBottomButtonCallback != nil {
            self.rightBottomButtonCallback!()
        }
    }
}

