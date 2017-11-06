//
//  MyBankCardController.swift
//  JSApp
//
//  Created by lufeng on 16/2/22.
//  Copyright © 2016年 lufeng. All rights reserved.
//

import UIKit

class MyBankCardController: BaseViewController {
    var model:MyBankCardModel? {
        didSet {
            idCards.text = model?.map?.idCards
            realName.text = model?.map?.realName
            if let bankNum = model?.map?.bankNum {
                bankName.text = "尾号" + bankNum
            }
            if let phone = model?.map?.phone {
                mobilephone.text = phone.phoneNoAddAsterisk()
            }
            if let bankCod = model?.map?.bankCode {
                bankCode.image = UIImage(named: "\(bankCod)")
            }
            if let singleQuota = model?.map?.singleQuota {
                titleOne.text = "● " + "银行充值单笔限额为" + "\(singleQuota.thousandPoint())" + "元"
            }
            if model?.map?.dayQuota == 0{
                titleTwo.text = "● " + "银行充值每日无限额"
            }else if let dayQuota = model?.map?.dayQuota {
                titleTwo.text = "● " + "银行充值每日限额为" + "\(dayQuota.thousandPoint())" + "元"
            }
            titleThree.text = "● " + "银行提现单笔限额为" + "\(500000.00.thousandPoint())" + "元"
        }
    }
    
    @IBOutlet weak var titleThree: UILabel!
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var titleTwo: UILabel!
    @IBOutlet weak var idCards: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var mobilephone: UILabel!
    @IBOutlet weak var bankCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "银行卡"
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience  init() {
        let nibNameOrNil = String?("MyBankCardController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setupData() {
        view.showLoadingHud()
        weak var weakSelf = self
        MyBankCardApi(Uid: UserModel.shareInstance.uid ?? 0).startWithCompletionBlock(success: { (request: YTKBaseRequest!) -> Void in
            
            weakSelf!.view.hideHud()
            let resultDict = request.responseJSONObject as? [String: AnyObject]
            weakSelf!.model = MyBankCardModel(dict: resultDict!)
            }) { (request: YTKBaseRequest!) -> Void in
               
        }
    }
}
