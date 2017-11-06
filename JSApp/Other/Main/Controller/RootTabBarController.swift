//
//  RootTabBarController.swift
//  JSApp
//
//  Created by user on 16/6/24.
//  Copyright © 2016年 lufeng. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    var defaultImageArray: [String] = []
    var selectImageArray: [String] = []
    var itemTitleArray: [String] = []
     
    var model: TabbarActivityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildViewControllers()
        self.createBarItem()
    }
    
    //MARK: 初始化子控制器
    func setupChildViewControllers() {
        self.addChildVC(MainViewController())
        let investVC = JSInvestFinancingActivityController()
        investVC.type = 2
        investVC.isShowLeftItem = false
        self.addChildVC(investVC)
        self.addChildVC(DiscoverViewController())
        self.addChildVC(JSMyAccountViewController())
    }
    
    //MARK: 添加子控制器
    func addChildVC(_ vc:UIViewController) {
        self.addChildViewController(RootNavigationController(rootViewController:vc))
    }
    
    //MARK: 创建tabBarItem
    func createBarItem() {
        self.view.backgroundColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        self.itemTitleArray = ["精选","理财","发现","我的"]
        self.defaultImageArray = ["jingxuan","invest","find","me"]
        self.selectImageArray = ["jingxuan_s","invest_s","find_s","me_s"]
        
        var dict:[String:AnyObject] = [:]
        dict[NSForegroundColorAttributeName] = Default_TabBar_Title_Color
        UITabBarItem.appearance().setTitleTextAttributes(dict, for: UIControlState.selected)
        
        for i in 0...defaultImageArray.count - 1 {
            let item = UITabBarItem()
            item.image = UIImage(named: defaultImageArray[i])
            item.title = itemTitleArray[i]
            item.selectedImage = UIImage(named: selectImageArray[i])
            
            item.imageInsets = UIEdgeInsets(top: 3,left: 0,bottom: -3,right: 0)
            self.viewControllers![i].tabBarItem = item
        }
    }
}
