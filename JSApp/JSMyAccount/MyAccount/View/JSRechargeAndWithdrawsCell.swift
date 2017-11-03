//
//  JSRechargeAndWithdrawsCell.swift
//  JSApp
//
//  Created by Feng Lu on 2017/2/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSRechargeAndWithdrawsCell: UITableViewCell{
    @IBOutlet weak var withdrawBtn: UIButton!       //提现
    @IBOutlet weak var rechargeBtn: UIButton!       //充值
    @IBOutlet weak var alertView: UIView!       //温馨提示View
    @IBOutlet weak var alertMsgLabel: UILabel!  //温馨提示消息
    @IBOutlet weak var alertIcon: UIImageView!  //温馨提示图标
    
    var withdrawBlock:(()->())!        //提现block
    var rechargeBlock:(()->())!        //充值block
    var newHandBlock:(()->())!         //新手标block
//    var closeAlertViewBlock:((_ view: UIView)->())!   //关闭提示block
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
        self.alertMsgLabel.numberOfLines = 0;
    alertMsgLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(JSRechargeAndWithdrawsCell.newhandClick)))
        
       alertMsgLabel.isUserInteractionEnabled = true
        
    }
    
    func setupView()
    {
        withdrawBtn.layer.cornerRadius = 5.0
        withdrawBtn.layer.masksToBounds = true
        withdrawBtn.layer.borderColor = UIColorFromRGB(192, green: 192, blue: 192).cgColor
        withdrawBtn.layer.borderWidth = 1.0
        
        rechargeBtn.layer.cornerRadius = 5.0
        rechargeBtn.layer.masksToBounds = true
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //显示与隐藏alertView
    func setupModel(_ model:MyAccountModel?)
    {
        alertView.isHidden = true
        if model?.map != nil && model?.map?.Push != nil
        {
            alertView.isHidden = false
            self.alertMsgLabel.text = model?.map?.Push
            print("\(String(describing: self.alertMsgLabel.text))")
        }
        else
        {
           alertView.isHidden = true
        }
    }
    
    //MARK: 关闭温馨提示
    @IBAction func closeAlertView(_ sender: UIButton) {
        
//        if let block = closeAlertViewBlock() {
//             block(alertView)
//        }
        alertView.isHidden = true

    }
    
    //MARK: 提现
    @IBAction func withdrawClick(_ sender: UIButton) {
        if let block = withdrawBlock{
            block()
        }
    }
    
    //MARK: 充值
    @IBAction func rechargeClick(_ sender: UIButton) {
        if let block = rechargeBlock{
            block()
        }
    }
    
    
    //MARK: 温馨提示到新手标
    func newhandClick(){
        if let block = newHandBlock{
            block()
        }
    }
    
}



