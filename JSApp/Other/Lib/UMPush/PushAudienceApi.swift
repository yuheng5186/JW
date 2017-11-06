//
//  PushAudienceApi.swift
//  JSApp
//
//  Created by 一言难尽 on 2017/3/13.
//  Copyright © 2017年 wangyuxi. All rights reserved.
//

import UIKit

class PushAudienceApi: BaseApi {

    var uid: Int = 0
    var registrationId: String = ""
    var appType: Int = 0 //0: 友盟  1： 极光
    
    init(Uid: Int,RegistrationId: String,AppType: Int) {
        super.init()
        self.uid = Uid
        self.registrationId = RegistrationId
        self.appType = AppType
    }
    
    override func requestUrl() -> String! {
        return Set_Push_RegistrationId
    }
    
    override func untreatedArgument() -> Any! {
        return ["uid": uid,"registrationId": registrationId,"appKey": UMENG_KEY]
    }
}
