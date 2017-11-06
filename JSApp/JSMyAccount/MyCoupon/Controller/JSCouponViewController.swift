//
//  JSCouponViewController.swift
//  JSApp
//
//  Created by Feng Lu on 2017/2/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSCouponViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var listView: UITableView!
    var couponType:Int = 0
//    var invalidCouponBtn:UIButton!  //查看失效优惠券
    var model:MyCouponsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.model == nil {
            //加载数据
            self.loadData()
        }
    }
    
    //MARK: - 数据
    override func loadData()
    {
        view.showLoadingHud()
        weak var weakSelf = self
        print("输出请求参数\(UserModel.shareInstance.uid)以及\(couponType)")
        MyActivityApi(Uid: UserModel.shareInstance.uid ?? 0, Status:0,Flag: couponType).startWithCompletionBlock(success: { (request: YTKBaseRequest!) -> Void in
            weakSelf!.view.hideHud()
            weakSelf!.listView.mj_header.endRefreshing()
            let resultDict = request.responseJSONObject as? [String: AnyObject]
            print("输出我的优惠券\(resultDict)")
            
            if resultDict == nil {
                weakSelf!.loadDataError()
                weakSelf!.errorView.errInoLB.text = "网络中断链接，请检查您的网络设置"
                return
            }
            
            self.model = MyCouponsModel(dict: resultDict!)
            if weakSelf!.model?.success == false {
                weakSelf!.loadDataError()
                weakSelf!.errorView.errInoLB.text = "网络中断链接，请检查您的网络设置"
                return
            }
            
            if weakSelf!.model?.map?.list.count == 0 {
                weakSelf!.loadDataError()
                
                if self.couponType == 2 {
                    weakSelf!.errorView.errInoLB.text = "没有红包"
                } else if self.couponType == 3 {
                    weakSelf!.errorView.errInoLB.text = "没有加息券"
                } else if self.couponType == 4 {
                    weakSelf!.errorView.errInoLB.text = "没有翻倍券"
                }
                
                return
            }
            
            if weakSelf!.errorView != nil {
                weakSelf!.errorView.isHidden = true
            }
            weakSelf!.listView.reloadData()
        }) { (request: YTKBaseRequest!) -> Void in
            weakSelf!.listView.mj_header.endRefreshing()
            weakSelf!.loadDataError()
            weakSelf!.errorView.errInoLB.text = "网络中断链接，请检查您的网络设置"
        }
    }
    
    //MARK: - 初始化view
    func setupView() {
        
        //listView
        print("屏幕的高度 == \(SCREEN_HEIGHT)")
        self.listView = UITableView(frame: CGRect(x: 0,y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 160))
        
        self.listView.backgroundColor = DEFAULT_GRAYCOLOR
        self.listView.dataSource = self
        self.listView.delegate = self
        self.listView.separatorStyle = UITableViewCellSeparatorStyle.none
        
//        invalidCouponBtn = UIButton(frame: CGRect(x: 0, y: listView.height + listView.y + 5, width: SCREEN_WIDTH, height: 40))
//        invalidCouponBtn.setTitle("失效优惠券", forState: .Normal)
//        invalidCouponBtn.setTitleColor(UIColorFromRGB(21, green: 21, blue: 21), forState: .Normal)
//        invalidCouponBtn.backgroundColor = UIColor.whiteColor()
//        invalidCouponBtn.addTarget(self, action: #selector(JSCouponViewController.invalidCouponClick(_:)), forControlEvents: .TouchUpInside)
//        self.view.addSubview(invalidCouponBtn)
        
        self.listView.mj_header = MJRefreshNormalHeader {
            //加载数据
            self.loadData()
        }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        footerView.backgroundColor = DEFAULT_GRAYCOLOR
        self.listView.tableFooterView = footerView
        self.view.addSubview(self.listView)

    }
    //MARK: - 查看失效优惠券
//    func invalidCouponClick(sender:UIButton)
//    {
//        print("点击查看失效券")
//        let validCouponVC = JSInvalidCouponViewController()
//        self.navigationController?.pushViewController(validCouponVC, animated: true)
//    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.model == nil {
            return 0
        }
        return (self.model?.map?.list.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return JSMyCouponCell.cellHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "JSMyCouponCell") as! JSMyCouponCell!
        if cell == nil
        {
            cell = Bundle.main.loadNibNamed("JSMyCouponCell", owner: self, options: nil)?.first as? JSMyCouponCell
        }
        cell?.selectionStyle = .none
        
        //数据
        if model?.map?.list.count != 0 {
            cell?.setupModel((model?.map?.list[indexPath.row])!)
        }
        return cell!
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if self.model?.map?.list[indexPath.row].type == 3
//        {
//            //获取新手标的id，然后跳转
//            self.loadMainData()
//        }
//        else
//        {
//            //砸蛋加息券
//            if model?.map?.list.count != 0
//            {
//                let couponModel = model?.map?.list[indexPath.row]
//                if couponModel?.pid == 0 {
//                    NotificationCenter.default.post(name: Notification.Name(rawValue: GoToInvestViewControllerPostNotification), object: nil)
//                    self.dismiss(animated: true, completion: nil)
//                }
//                else if couponModel?.pid != 0
//                {
//                    //MARK: - 
//                    let productDetailVC = JSInvestDetailViewController()
//                    productDetailVC.productNameID = couponModel?.pid
//                    self.navigationController?.pushViewController(productDetailVC, animated: true)
//                    
//                }
//            }
//        }
//
//    }
    
    //MARK: 获取新手标的id，然后才可以跳转
    func loadMainData(){
        self.view.showLoadingHud()
        var uid = 0
        if UserModel.shareInstance.isLogin == 1 {
            uid = UserModel.shareInstance.uid!
        }
        weak var weakSelf = self
        HomeApi(Uid: uid).startWithCompletionBlock(success: { (request: YTKBaseRequest!) -> Void in
            self.view.hideHud()
            let resultDict = request.responseJSONObject as? [String: AnyObject]
            let homeModel = HomeModel(dict: resultDict!)
            if homeModel.success {
                self.toNoviceVC((homeModel.map?.newHand?.id)!)
            } else if homeModel.errorCode == "9998" {
                //弹出登录控制器
                JSLoginViewController.presentLoginControllerDismissGoHomeType(self)
            } else {
                weakSelf!.view.showTextHud("网络错误,请稍后重试")
                
            }
            
        }) { (request: YTKBaseRequest!) -> Void in
            self.view.hideHud()
            weakSelf!.view.showTextHud("网络错误,请稍后重试")
        }
    }

    //MARK: 去新手页 - 待做
    func toNoviceVC(_ pid:Int){
//        let NoviceBuy = JSNewhandDetailViewController()
//        NoviceBuy.id = pid
//        navigationController!.navigationBarHidden = false
//        self.navigationController?.pushViewController(NoviceBuy, animated: true)
    }

    //MARK: - 设置XIB
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience  init() {
        let nibNameOrNil = String?("JSCouponViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
}
