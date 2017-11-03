//
//  GoPayModel.swift
//  JSApp
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 lufeng. All rights reserved.
//

import UIKit

class GoPayModel: BaseModel {
    var success:Bool = false
    var errorCode:String = ""
    var map:GoPayMapModel?
    // MARK: - 构造函数
    
    init(dict: [String: AnyObject]) {
        super.init()
        // KVC
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        
        if key == "map" {
            // 判断 value 是否是 一个 有效的 字典
            if let dict = value as? [String: AnyObject] {
                // 创建用户数据
                map = GoPayMapModel(dict: dict)
            }
            return
        }
//        if key == "errorCode" {
//            let dict = ["9999": "系统错误",
//                "1001": "充值金额有误",
//                "1002":"验证码不能为空",
//                "1003":"验证码错误",
//                "1004":"处理中",
//                "1005":"系统错误，请稍后重试",
//                "1006":"超出单卡号累计交易次数限制",
//                "1007":"超出银行授信额度",
//                "1008":"超过用户在银行设置的限额",
//                "1009":"持卡人身份证验证失败",
//                "1010":"累计交易支付金额超出单笔限额",
//                "1011":"累计交易支付金额超出当日限额",
//                "1012":"累计交易支付金额超出当月限额",
//                "1013":"非法用户号",
//                "1014":"该卡暂不支持支付,请更换银行卡",
//                "1015":"该卡暂不支持支付，请稍后再试",
//                "1016":"交易超时",
//                "1017":"交易金额不能大于最大限额",
//                "1018":"交易金额不能低于最小限额",
//                "1019":"交易金额超过渠道当月限额",
//                "1020":"交易金额为空",
//                "1021":"交易金额有误错误",
//                "1022":"交易失败，风险受限",
//                "1023":"交易失败，详情请咨询您的发卡行",
//                "1024":"金额格式有误",
//                "1025":"仅支持个人银行卡支付",
//                "1026":"您的银行卡不支持该业务，请与发卡行联系",
//                "1027":"请核对个人身份证信息",
//                "1028":"请核对您的订单号",
//                "1029":"请核对您的个人信息",
//                "1030":"请核对您的银行卡信息",
//                "1031":"请核对您的银行信息",
//                "1032":"请核对您的银行预留手机号",
//                "1033":"未开通无卡支付或交易超过限额",
//                "1034":"信息错误，请核对",
//                "1035":"银行户名不能为空",
//                "1036":"银行卡未开通银联在线支付",
//                "1037":"银行名称无效",
//                "1038":"银行系统繁忙,请稍后再试",
//                "1039":"银行账号不能为空",
//                "1040":"余额不足",
//                "1041":"证件号错误,请核实",
//                "1042":"证件号码不能为空",
//                "1043":"证件类型与卡号不符",
//                "1045":"银行账户余额不足",
//                "1044":"银行账户余额不足"]
//            errorCode = dict[value as! String]!
//            return
//        }
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        super.setValue(value, forUndefinedKey: key)
    }

}
