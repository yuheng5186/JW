//
//  RechargeHomeModel.swift
//  JSApp
//
//  Created by lufeng on 16/3/8.
//  Copyright © 2016年 lufeng. All rights reserved.
//

import UIKit

class RechargeHomeModel: NSObject {
    var map :RechargeHomeMapModel?
    var success:Bool = false
    var errorCode:String?
    
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        // KVC
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "map" {
            // 判断 value 是否是 一个 有效的 字典
            if let dict = value as? [String: AnyObject] {
                // 创建用户数据
                map = RechargeHomeMapModel(dict: dict)
            }
            return
        }
        if key == "errorCode" {
            let dict = ["9999": "系统错误"]
            errorCode = dict[value as! String]
            return
        }
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
