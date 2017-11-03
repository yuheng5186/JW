//
//  JSWithdrawViewController1.swift
//  JSApp
//
//  Created by Feng Lu on 2017/4/20.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class JSWithdrawViewController1: BaseViewController,UITextFieldDelegate,UIAlertViewDelegate {
    @IBOutlet weak var bgScrollView: UIScrollView!
    @IBOutlet weak var bgView1: UIView!         //白色图标
    @IBOutlet weak var bgView2: UIView!
    @IBOutlet weak var bankImgView: UIImageView!//银行图标
    @IBOutlet weak var bankTitleLabel: UILabel! //银行名称
    @IBOutlet weak var bankLabel: UILabel!      //银行卡号
    @IBOutlet weak var availableBalanceLabel: UILabel!  //可用余额
    @IBOutlet weak var amountTextField: UITextField!    //输入框
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!        //手续费扣除提示
    
    var contentArr:[String] = []            //友情提示内容
    var bankName:[String] = []              //银行名称
    var model:WithdrawalsHomeMapModel?             //数据
    var withdrawModel:WithdrawalsGoModel?
    var isNeedShowPasswordView:Bool = false        //忘记密码页跳转回来显示输入密码框
    var password:String?           = ""            //交易密码

    override func viewDidLoad() {
        super.viewDidLoad()
        MobClick.event("0500008")
        //变量初始化
        varSetup()
        //创建view
        setupView()
        //数据
        loadData()

    }
    override func leftBarButtonItemAction() {
        super.leftBarButtonItemAction()
        MobClick.event("0500011")
    }
    //MARK: 连接API获取数据
    override func loadData(){
        if self.errorView != nil {
            self.errorView.isHidden = true
        }
        weak var weakSelf = self
        if UserModel.shareInstance.uid > 0 && UserModel.shareInstance.isLogin == 1
        {
            weakSelf!.view.showLoadingHud()
            MyInformationApi(Uid: UserModel.shareInstance.uid!).startWithCompletionBlock(success: { (request: YTKBaseRequest!) -> Void in
                let resultDict = request.responseJSONObject as? [String: AnyObject]
                print("我要提现 -》我的信息首页\(resultDict)")
                let myInfo = MyInformationModel(dict: resultDict!)
                weakSelf!.view.hideHud()
                if !myInfo.success {
                    weakSelf!.view.showTextHud("信息获取失败")
                    weakSelf!.loadDataError()
                    return
                } else {
                    UserModel.shareInstance.tpwdFlag = myInfo.map?.tpwdFlag
                    weakSelf!.refreshView()
                }
                
                }, failure: { (request: YTKBaseRequest!) -> Void in
                    weakSelf!.view.showTextHud("信息获取失败")
                    weakSelf!.loadDataError()
            })
        }
        else
        {
            weakSelf!.navigationController?.popViewController(animated: true)
        }
    }

    //MARK: - 视图刷新
    func refreshView() {
        
        bankImgView.image = UIImage(named:"js\((model?.bankCode)!)")
        
        if model!.bankCode == 21{
            bankTitleLabel.text = "洛阳银行"
        } else if model!.bankCode == 22{
            bankTitleLabel.text = "上海农商银行"
        } else {
            bankTitleLabel.text = bankName[(model?.bankCode)! - 1]
        }
        
        bankLabel.text = "尾号\((model?.bankNum)!)"
        
        let funsStr = String(format: "%.2f", (model?.funds)!)
        //账户余额
        self.availableBalanceLabel.text = PD_NumDisplayStandard.numDisplayStandard(funsStr, decimalPointType: 2, numVerification: false)
        
        if model?.isChargeFlag == 1 {
            amountTextField.placeholder = "最少3元"
            setAttributedString("预计下个工作日16点前到账，手续费2.00元", subString:"2.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "2.00".characters.count, label: alertLabel)
//            setAttributedString("额外扣除手续费2.00元", subString: "2.00", location: "额外扣除手续费".characters.count, length: "2.00".characters.count, label: alertLabel)
            
        } else {
            amountTextField.placeholder = "最少1元"
            setAttributedString("预计下个工作日16点前到账，手续费0.00元", subString:"0.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "0.00".characters.count, label: alertLabel)
        }
        
//                if UserModel.shareInstance.tpwdFlag != 1 {
//                    self.passwordTextField.placeholder = "请设置交易密码"
//                } else {
//                    self.passwordTextField.placeholder = "请输入交易密码"
//                }
    }

    //MARK: - 确认按钮提交
    @IBAction func commitBtnClick(_ sender: UIButton) {
        MobClick.event("0500010")
        self.view.endEditing(true)
        if !(self.amountTextField.text!.verifyNumberTwo()) {
            self.view.showTextHud("请输入正确的金额")
            return
        }
        
        if self.model?.isChargeFlag == 1
        {
            if (self.amountTextField.text! as NSString).doubleValue < 3.00
            {
                self.alertLabel.text = "提现金额至少为3元"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
                return
            }
//            else if (self.amountTextField.text! as NSString).doubleValue >= 3.00 && (self.amountTextField.text! as NSString).doubleValue <= model?.funds && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
//            {
//                self.commitButton.isEnabled = true
//                self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
//            }
//            else
//            {
//                self.commitButton.isEnabled = false
//                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
//                self.alertLabel.text = "提现金额超过可用余额"
//                self.alertLabel.textColor = DEFAULT_GREENCOLOR
//                delay(1.5, block: {
//                    self.alertLabel.text = ""
//                })
//                
//                return
//            }
        }
        else
        {
            if (self.amountTextField.text! as NSString).doubleValue < 1.00
            {
//                self.commitButton.isEnabled = false
//                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
                self.alertLabel.text = "提现金额至少为1元"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
//                delay(1.5, block: {
//                    self.alertLabel.text = ""
//                })
                
                return
            }
//            else if (self.amountTextField.text! as NSString).doubleValue >= 1.00 && (self.amountTextField.text! as NSString).doubleValue <= model?.funds && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
//            {
//                self.commitButton.isEnabled = true
//                self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
//            }
//            else
//            {
//                self.commitButton.isEnabled = false
//                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
//                self.alertLabel.text = "提现金额超过可用余额"
//                self.alertLabel.textColor = DEFAULT_GREENCOLOR
//                delay(1.5, block: {
//                    self.alertLabel.text = ""
//                })
//                
//                return
//            }
        }

        if self.model?.isChargeFlag == 0 && (Double)(self.amountTextField.text!)! < 1.00 {
            self.view.showTextHud("提现金额最小为1元")
            return
        }
        
        if self.model?.isChargeFlag == 1 && (Double)(self.amountTextField.text!)! < 3.00 {
            self.view.showTextHud("提现金额最小为3元")
            return
        }
        
        if (self.amountTextField.text! as NSString).doubleValue > 500000.00 || (self.amountTextField.text! as NSString).doubleValue > model?.funds {
            self.view.showTextHud("请输入正确的提现金额")
            return
        }
        if UserModel.shareInstance.tpwdFlag == 0 {
            
            let alertView = UIAlertView()
            alertView.tag = 101
            alertView.title = "提示"
            alertView.message = "为了保障资金安全，请先设置交易密码！"
            alertView.addButton(withTitle: "取消")
            alertView.addButton(withTitle: "设置")
            alertView.delegate = self
            alertView.show()
            return
        }
        self.showPassWordView()
    }
    
    //MARK: - 限制金额
    func changeValue()
    {
        self.availableBalanceLabel.text = String(format: "%.2f", model!.funds)
        if self.amountTextField.text?.characters.count == 0
        {
            if model?.isChargeFlag == 1 {
                amountTextField.placeholder = "最少3元"
                setAttributedString("预计下个工作日16点前到账，手续费2.00元", subString:"2.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "2.00".characters.count, label: alertLabel)
                
            } else {
                amountTextField.placeholder = "最少1元"
                setAttributedString("预计下个工作日16点前到账，手续费0.00元", subString:"0.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "0.00".characters.count, label: alertLabel)
            }

            self.commitButton.isEnabled = false
            self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
        }
        
//        if (amountTextField.text! as NSString).doubleValue >= 1.00 && (self.amountTextField.text! as NSString).doubleValue <= model?.funds && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
//        {
//            self.commitButton.isEnabled = true
//            self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
//        }
//        else
//        {
//            self.commitButton.isEnabled = false
//            self.commitButton.backgroundColor = UIColor.gray
//        }

        
//        else if (self.amountTextField.text! as NSString).doubleValue > 0.00
//        {
//            self.commitButton.isEnabled = true
//            self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
//        }
//        else if (self.amountTextField.text! as NSString).doubleValue >= 3.00 && Double(self.amountTextField.text!)! <= model!.funds
//        else if (self.amountTextField.text! as NSString).doubleValue > 0.00 && (self.amountTextField.text! as NSString).doubleValue <= model!.funds
//        {
//            self.commitButton.isEnabled = true
//            self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
//            
//            //去掉金额输入变化
////            let str = "\(Double(self.availableBalanceLabel.text!)! - Double(self.amountTextField.text!)!)"
////            self.availableBalanceLabel.text = PD_NumDisplayStandard.numDisplayStandard(str, decimalPointType: 2, numVerification: false)
//        }
        
        
//        if (self.amountTextField.text! as NSString).doubleValue > model!.funds
//        {
//            self.commitButton.isEnabled = false
//            self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
//            self.alertLabel.text = "提现金额超过可用余额"
//            self.alertLabel.textColor = DEFAULT_GREENCOLOR
//        }
        
        if self.model?.isChargeFlag == 1
        {
            if (self.amountTextField.text! as NSString).doubleValue < 3.00
            {
//                amountTextField.placeholder = "最少1元"
//                setAttributedString("预计下个工作日16点前到账，手续费0.00元", subString:"0.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "0.00".characters.count, label: alertLabel)
                self.commitButton.isEnabled = false
                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)

                self.alertLabel.text = "提现金额至少为3元"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
            }
            else if (self.amountTextField.text! as NSString).doubleValue >= 3.00 && (self.amountTextField.text! as NSString).doubleValue <= model?.funds && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
            {

                self.commitButton.isEnabled = true
                self.commitButton.backgroundColor = DEFAULT_GREENCOLOR
                alertLabel.textColor = UIColor.black
                setAttributedString("预计下个工作日16点前到账，手续费2.00元", subString:"2.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "2.00".characters.count, label: alertLabel)

            }
            else
            {
                self.commitButton.isEnabled = false
                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
                self.alertLabel.text = "提现金额超过可用余额"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
            }
        }
        else
        {
            if (self.amountTextField.text! as NSString).doubleValue < 1.00
            {
                self.commitButton.isEnabled = false
                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
                self.alertLabel.text = "提现金额至少为1元"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR

//                amountTextField.placeholder = "最少3元"
//                setAttributedString("预计下个工作日16点前到账，手续费2.00元", subString:"2.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "2.00".characters.count, label: alertLabel)
            }
            else if (self.amountTextField.text! as NSString).doubleValue >= 1.00 && (self.amountTextField.text! as NSString).doubleValue <= model?.funds && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
            {
                self.commitButton.isEnabled = true
                self.commitButton.backgroundColor = DEFAULT_GREENCOLOR

                alertLabel.textColor = UIColor.black
                setAttributedString("预计下个工作日16点前到账，手续费0.00元", subString:"0.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "0.00".characters.count, label: alertLabel)
            } else if (self.amountTextField.text! as NSString).doubleValue >= 1.00 && (self.amountTextField.text! as NSString).doubleValue >= (model?.funds)! && (self.amountTextField.text! as NSString).doubleValue <= 500000.00
            {
                self.commitButton.isEnabled = false
                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
                self.alertLabel.text = "提现金额超过可用余额"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
            } else {
                self.commitButton.isEnabled = false
                self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
                self.alertLabel.text = "提现金额超过银行限额"
                self.alertLabel.textColor = DEFAULT_GREENCOLOR
            }
        }
    }
    
    //MARK: - 交易密码
    func showPassWordView() {
        weak var weakSelf = self
        let pwdView = JSWithdrawTradePasswordView()
        
        pwdView.forgetPassword = {()->() in
            pwdView.dismissView()
            MobClick.event("0500013")
            weakSelf?.isNeedShowPasswordView = true
            let forgetPasswordVC = JYPassWordController()
            self.navigationController?.pushViewController(forgetPasswordVC, animated: true)
        }
        
        pwdView.setupModel(self.amountTextField.text!, isHaveFee: (self.model?.isChargeFlag)!)
        pwdView.showView(UIApplication.shared.keyWindow!)
        
        // 交易密码输入完成block
        pwdView.completeBlock = {(psWord: String) -> Void in
            MobClick.event("0500012")
            self.password = psWord
            self.commitButton.isEnabled = false
            pwdView.contentView.showLoadingHud()
            
            weak var weakSelf = self
            WithdrawalsGoApi(Uid: UserModel.shareInstance.uid ?? 0, Amount: self.amountTextField.text, Tpw:jm().sbjm(self.password!) , IsChargeFlage:(self.model?.isChargeFlag)!).startWithCompletionBlock(success: { (request: YTKBaseRequest!) -> Void in
                pwdView.contentView.hideHud()
                self.commitButton.isEnabled = true
                let resultDict = request.responseJSONObject as? [String: AnyObject]
                print("提现界面的数据\(resultDict)")
                
                let model:WithdrawalsGoModel = WithdrawalsGoModel(dict: resultDict!)
                self.withdrawModel = WithdrawalsGoModel(dict: resultDict!)
                if model.success == false && (model.errorCode) != "1006" {
                    print("提现界面\(model.errorCode)")
                    if model.errorCode == "1003" {
                        pwdView.tradePwdView.layer.borderColor = DEFAULT_GREENCOLOR.cgColor
                        pwdView.errorLabel.text = "您输入的交易密码错误，请重新输入"
                        
                        delay(1.8, block: {
                            pwdView.clearTradePwd()
                            pwdView.tradePwdView.layer.borderColor = UIColorFromRGB(219, green: 219, blue: 219).cgColor
                            pwdView.errorLabel.text = ""
                        })
                        
                    } else if model.errorCode == "2001" {
                        pwdView.dismissView()
                        
                        let alertView = UIAlertView()
                        alertView.tag = 102
                        alertView.title = "提示"
                        alertView.message = "连续输错三次，您的交易密码已被锁定！请一小时后再试，或点击忘记密码。"
                        alertView.addButton(withTitle: "稍后再试")
                        alertView.addButton(withTitle: "忘记密码")
                        alertView.delegate = self
                        alertView.show()
                        return
                    } else if model.errorCode == "1007" {
                        self.setAttributedString("额外扣除手续费2.00元", subString: "2.00",location: "额外扣除手续费".characters.count, length: "2.00".characters.count, label: self.alertLabel)
                        weakSelf!.model?.isChargeFlag = 1
                        
                    } else if model.errorCode == "1008" {
                        weakSelf!.alertLabel.text = ""
                        weakSelf!.model?.isChargeFlag = 0
                        
                    } else {
                        pwdView.dismissView()
                        var errorMsg: String = ""
                        let dict = ["9999": "系统错误", "1001": "提现金额有误","1002":"交易密码不能为空", "1003": "交易密码错误","1004":"余额不足","1005":"提现失败，请再次申请","1006":"处理中","1007":"该笔需要收取手续费","1008":"该笔不需要收取手续费","1009":"渠道不能为空","2001":"连续输错三次，您的交易密码已被锁定！","2002":"返现或体验金收益需完成一次真实投资后才可提现","XTWH":"系统维护"]
                        errorMsg = dict[model.errorCode]!
                        let error = "\(model.errorCode):" + errorMsg
                        weakSelf!.view.showTextHud(error)
                    }
                } else {
                    pwdView.dismissView()
                    if model.errorCode != "" && (model.errorCode) == "1006" {
                        weakSelf!.view.showTextHud("处理中")
                        self.withdrawSuccess(1,amount:self.amountTextField.text!)
                    } else {
                        weakSelf!.view.showTextHud("提现成功")
                        self.withdrawSuccess(2,amount:self.amountTextField.text!)
                    }
                }
                
                }, failure: { (request: YTKBaseRequest!) -> Void in
                    pwdView.contentView.hideHud()
                    pwdView.dismissView()
                    weakSelf!.view.showTextHud("网络错误")
                    self.commitButton.isEnabled = true
            })
        }
    }
    
    //MARK: - 提现成功界面
    func withdrawSuccess(_ processStatus:Int,amount:String)
    {
        let withdrawSuccessVC = JSPaySuccessViewController()
        withdrawSuccessVC.toFrom = 2
        withdrawSuccessVC.processStatus = processStatus
        withdrawSuccessVC.withdrawModel = self.withdrawModel
        withdrawSuccessVC.withdrawAmount = (amount as NSString).doubleValue
        self.navigationController?.pushViewController(withdrawSuccessVC, animated: true)
    }

    //MARK: - 初始化view
    func setupView()
    {
        navigationItem.title = "提现"
        bgScrollView.alwaysBounceVertical = true
        bgScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 100)
        
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(JSWithdrawViewController1.changeValue), for: .allEvents)
        //修改键盘（数字+小数点）
        amountTextField.keyboardType = UIKeyboardType.decimalPad
        
        bgView1.backgroundColor = UIColor.white
        bgView1.layer.cornerRadius = 42 / 2
        bgView1.layer.masksToBounds = true
        
        bgView2.backgroundColor = UIColor.white
        bgView2.layer.cornerRadius = 42 / 2
        bgView2.layer.masksToBounds = true
        
        self.commitButton.layer.cornerRadius = 5.0
        self.commitButton.layer.masksToBounds = true
    }
    
    //MARK: -  变量初始化
    func varSetup()
    {
        contentArr = ["● 每位用户每月可享受2次免费提现，超出后提现手续费为2元/笔，手续费将从您的账户余额中扣除； ",
                      "● 工作日16点前的提现申请当天到账；",
                      "● 工作日16点后的提现申请，顺延至下个工作日（具体到账时间以银行处理时间为准）；",
                      "● 周末和法定节假日提现，到账时间顺延至下个工作日；",
                      "● 返现或体验金收益需完成一次真实投资后才可提现；",
                      "● 若提现过程中遇到任何问题，请及时联系我们 \(SERVER_PHONE)。"]
        
        bankName = ["中国工商银行","中国农业银行","中国建设银行","中国银行","中国邮政储蓄银行","招商银行","兴业银行","中国光大银行","广发银行","平安银行","中国民生银行","浦发银行","中信银行","上海银行","北京银行","交通银行","兰州银行","华夏银行"]
        
    }
    //MARK: - 创建label
    func getDisplayLabel() -> UILabel {
        let promptContentLabel = UILabel(frame:CGRect.zero)
        bgScrollView.addSubview(promptContentLabel)
        promptContentLabel.font = UIFont.systemFont(ofSize: 14)
        promptContentLabel.textColor = UIColorFromRGB(153, green: 153, blue: 153)
        promptContentLabel.numberOfLines = 0
        return promptContentLabel
    }
    
    //MARK: - 根据文字算高度
    func getHeight(_ content: String) -> CGFloat {
        if content == "" {
            return 0.0
        } else {
            let height = content.getTextRectSize(UIFont.systemFont(ofSize: 14),size:CGSize(width: SCREEN_WIDTH - 40.0, height: 3000.0)).size.height
            return height
        }
    }
    
    //MARK: 设置label
    func setupLabel(_ x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,font:CGFloat,textColor:UIColor,textAlignment:NSTextAlignment,text:String,ishaveBorder:Bool,view:UIView) -> UILabel
    {
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        if ishaveBorder {
            label.layer.cornerRadius = 2.0
            label.layer.masksToBounds = true
            label.layer.borderColor = DEFAULT_ORANGECOLOR.cgColor
            label.layer.borderWidth = 1.0
        }
        view.addSubview(label)
        return label
    }
    //MARK: 设置Attribute
    func setAttributedString(_ superString:String,subString:String,location:Int,length:Int,label:UILabel)
    {
        let attributedString = NSMutableAttributedString(string: superString)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: DEFAULT_GREENCOLOR, range: NSMakeRange(location,length))
        label.attributedText = attributedString
    }
    
    //MARK: - UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 101 || alertView.tag == 102 {
            //提示设置交易密码 //提示密码输错三次
            if buttonIndex == 0 {
                
            }else {
                self.isNeedShowPasswordView = true
                let vc = JYPassWordController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //MARK: - 文本输入框
    func textFieldDidBeginEditing(_ textField: UITextField) {
        MobClick.event("0500009")
        alertLabel.textColor = UIColor.black
        if model?.isChargeFlag == 1 {
            amountTextField.placeholder = "最少3元"
            setAttributedString("预计下个工作日16点前到账，手续费2.00元", subString:"2.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "2.00".characters.count, label: alertLabel)
            
        } else {
            amountTextField.placeholder = "最少1元"
            setAttributedString("预计下个工作日16点前到账，手续费0.00元", subString:"0.00", location: "预计下个工作日16点前到账，手续费".characters.count, length: "0.00".characters.count, label: alertLabel)
        }
        
        self.commitButton.isEnabled = false
        self.commitButton.backgroundColor = UIColorFromRGB(204, green: 204, blue: 204)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let existedLength = textField.text?.characters.count
        let selectedLength = range.length
        let replaceLength = string.characters.count
        
        if existedLength! - selectedLength + replaceLength > 11{
            return false
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^[0-9]*((\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options:.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options: .reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        return numberOfMatches != 0
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        amountTextField.resignFirstResponder()
    }

    //MARK: - 设置XIB
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience  init() {
        let nibNameOrNil = String?("JSWithdrawViewController1")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

}
