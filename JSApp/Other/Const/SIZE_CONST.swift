//
//  SIZE_CONST.swift
//  JSApp
//
//  Created by lufeng on 16/2/3.
//  Copyright © 2016年 lufeng. All rights reserved.
//

import UIKit

//屏幕尺寸
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

// 适配的比例
let PHONE_SCALE_X = ((SCREEN_WIDTH > 667) ? (1.0) : (SCREEN_WIDTH / 375))
let PHONE_SCALE_Y = ((SCREEN_HEIGHT > 667) ? (1.0) : (SCREEN_HEIGHT / 667))
let W320_PHONE_SCALE_Y : CGFloat = 568.0 / 667.0
let PHONE_FIT_W = SCREEN_WIDTH / 320
let PHONE_FIT_H = SCREEN_HEIGHT / 568

//适配比例
let SCREEN_SCALE_W = SCREEN_WIDTH / 320

//设备类型
let IS_IPHONE4 = (SCREEN_MAX_LENGTH == 480)
let IS_IPHONE5 = (SCREEN_MAX_LENGTH == 568)
let IS_IPHONE6 = (SCREEN_MAX_LENGTH == 667)
let IS_IPHONE6_PLUS = (SCREEN_MAX_LENGTH == 736)
let IS_IPHONE_X = (SCREEN_MAX_LENGTH == 812)

// 判断当前是否是 iphone 4 4s
let IS_PHONE_4 = (SCREEN_MAX_LENGTH == 480)
// 判断设备 是否是 iphone 5s 5 4 4s
let IS_PHONE_WIDTH_320 = (SCREEN_WIDTH == 320)



//系统 状态栏 导航栏 tabbar 高度
//状态栏高度
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
//导航栏高度
let NAVIBAR_HEIGHT = 44.0
//状态栏+导航栏高度
let TOP_HEIGHT = STATUSBAR_HEIGHT + CGFloat(NAVIBAR_HEIGHT)
//tabbar高度
let TABBAR_HEIGHT = IS_IPHONE_X ? 83.0 : 49.0



//字体大小
let FONT_SIZE_22 = UIFont.systemFont(ofSize: 22)

let FONT_SIZE_20 = UIFont.systemFont(ofSize: 20)

let FONT_SIZE_18 = UIFont.systemFont(ofSize: 18)

let FONT_SIZE_16 = UIFont.systemFont(ofSize: 16)

let FONT_SIZE_14 = UIFont.systemFont(ofSize: 14)

let FONT_SIZE_12 = UIFont.systemFont(ofSize: 12)

