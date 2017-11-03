//
//  COLOR_CONST.swift
//  JSApp
//
//  Created by gx on 2017/9/13.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import Foundation


func UIColorFromRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
}
func ColorFromRGBA(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}
func UIColorFromHex(_ hax: Int) -> UIColor {
    return UIColor(red: ((CGFloat)((hax & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hax & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hax & 0xFF)) / 255.0, alpha: 1.0)
}

let DEFAULT_GRAYCOLOR = UIColorFromRGB(240, green: 240, blue: 240)
let BORDER_GRAYCOLOR = UIColorFromRGB(210, green: 210, blue: 210)
let TITLE_GRAYCOLOR = UIColorFromRGB(180, green: 180, blue:180)
let DEFAULT_ORANGECOLOR = UIColorFromRGB(255, green: 100, blue: 0)
let DEFAULT_DARKGRAYCOLOR = UIColorFromRGB(122, green: 122, blue: 122)
let DEFAULT_NOTICECOLOR = UIColorFromRGB(243, green: 233, blue: 221)       //公告栏的颜色

let DEFAULT_BGCOLOR = UIColorFromRGB(241, green: 241, blue: 241)           //APP整体灰色背景
let VERTICALLINE_BGCOLOR = UIColorFromRGB(150, green: 150, blue: 150)      //理财列表页竖线背景色
let DEFAULT_TRACKCOLOR = UIColorFromRGB(235, green: 235, blue: 235)        //圆圈进度条背景色
let DEFAULT_PROGRESSCOLOR = UIColorFromRGB(229, green: 143, blue: 138)     //进度条颜色
let DEFAULT_GREENCOLOR = UIColorFromRGB(255, green: 69, blue: 69)          //APP全局红色
let DEFAULT_CELLCOLOR = UIColorFromRGB(230, green: 230, blue: 230)          //优惠券背景颜色

let DEFAULT_PWD_GRAYCOLOR = UIColorFromRGB(200, green: 200, blue: 200)      //交易密码灰色背景
let DEFAULT_PWD_REDCOLOR = UIColorFromRGB(238, green: 132, blue: 128)      //交易密码红色背景

//圆圈进度条
let DEFAULT_PROCOLOR = UIColorFromRGB(235, green: 235, blue: 235)  //底部圈颜色
let DEFAULT_TRACK = UIColorFromRGB(255, green: 69, blue: 69)      //进度条

//红色背景
let JS_REDCOLOR = UIColorFromRGB(255, green: 69, blue: 69)

//投资列表
//333333
let Default_All3_Color = UIColorFromRGB(51, green: 51, blue: 51)
//666666
let Default_All6_Color = UIColorFromRGB(102, green: 102, blue: 102)
//999999
let Default_All9_Color = UIColorFromRGB(153, green: 153, blue: 153)
//d6d6d6
let Default_D6_Color = UIColorFromRGB(214, green: 214, blue: 214)      //进度条灰色
//ff9593
let Default_FF9593_Color = UIColorFromRGB(255, green: 149, blue: 147)  //进度条底部红色
//f18583
let Default_Rate_Color = UIColorFromRGB(241, green: 133, blue: 131)     //列表收益  结束状态
//8c8c8c
let Default_Deadline_Color = UIColorFromRGB(140, green: 140, blue: 140)   //列表期限  结束状态

//APP2.0 TabBar选中的文字颜色 FF4545
let Default_TabBar_Title_Color = UIColorFromRGB(255, green: 69, blue: 69)
let Default_Red = UIColorFromHex(0x0F4545)        // 红色 不确定这个进制对不对

//弹窗的背景视图背景颜色
let PopView_BackgroundColor = UIColor(red: 1.0 / 255.0, green: 1.0 / 255.0, blue: 1.0 / 255.0, alpha: 0.4)

let GREEN_REVISE = UIColorFromRGB(255, green: 69, blue: 69) //常用修正绿色 用来解决xib和代码 RGB颜色设置不一样问题
//青色导航栏颜色  红色
let NAVIGATION_BLUE_COLOR = UIColorFromRGB(255, green: 69, blue: 69)
