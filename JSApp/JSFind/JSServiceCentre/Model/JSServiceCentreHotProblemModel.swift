//
//  JSServiceCentreHotProblemModel.swift
//  JSApp
//
//  Created by 一言难尽 on 2017/2/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSServiceCentreHotProblemModel: NSObject {
    
     var modelArray =  [JSServiceCentreHotProblemDetailModel]()

    //0: 热门问题 1:认证注册  2：安全保障 3： 充值提现 4：投资福利 5：产品介绍 6：其他问题
    required init(modelType: Int) {
        super.init()
        self.configureData(modelType)
    }
    
    func configureData(_ type: Int) -> () {
        
        if type == 0 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "1、请登录http://www.bocailicai.cn，然后点击右上角的“注册”，根据指引一步步操作即可。\n2、请到App Store 或者应用宝上直接搜索“币优铺理财”，下载手机应用即可注册。"
            model_0.title = "如何注册成为币优铺理财的会员？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "币优铺理财推荐的每一款产品均有相对应的资产，对借款企业信息进行详细的披露，同时对借款企业进行贷前、贷中、贷后管理。"
            model_1.title = "借款项目如何审核与管理？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "进入“我的账户”，点击【充值】按钮，进入充值页面，选择支付方式，并输入相应的信息进行充值。"
            model_2.title = "如何充值？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "成功注册投资即送588元新人专享投资红包。"
            model_3.title = "注册是否有红包？"
            modelArray.append(model_3)
            
            //5.
            let model_4 = JSServiceCentreHotProblemDetailModel()
            model_4.detailTitle = "币优铺理财30天常规标：最低100元起投，按100元递增，投资成功后T+1日计息，投资周期是30天，到期一次性还本付息，预期基础年化利率6.5%，币优铺理财平台活动加息1%。"
            model_4.title = "币优铺理财的30天常规标是怎么样的产品，收益是多少？"
            modelArray.append(model_4)
            
            //6.
            let model_5 = JSServiceCentreHotProblemDetailModel()
            model_5.detailTitle = "您可以利用闲钱、散钱进行投资理财，有效提升资金的流通和利用率，获得相应的收益回报（高于银行存款利息的收益）。"
            model_5.title = "成为币优铺理财会员有什么好处？"
            modelArray.append(model_5)
            
        } else if type == 1 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "1、请登录http://www.bocailicai.cn，然后点击右上角的“注册”，根据指引一步步操作即可。\n2、请到App Store 或者应用宝上直接搜索“币优铺理财”，下载手机应用即可注册。"
            model_0.title = "如何注册成为币优铺理财的会员？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "1.银行卡认证需要跟银行信息相连的，可以尝试更换另一张银行卡进行尝试。\n2.已经3次认证不通过的帐号，无法再进行认证，需要在后台设置重新认证，更换其他银行卡进行认证。\n3.三次验证失败后需要将客户的信息发邮件提交给技术处理。"
            model_1.title = "银行卡信息都正确，为什么不能通过认证？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "1.用户可能退订平台短信。\n2.自行设置了拦截功能。\n3.app版本未及时更新。\n如不属上述情况，可咨询在线客服，询问具体原因。"
            model_2.title = "注册与绑卡时收不到验证码是什么情况？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "建议关闭呼叫转移功能。"
            model_3.title = "设置交易密码收不到验证码怎么办？"
            modelArray.append(model_3)
            
        } else if type == 2 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "币优铺理财推荐的每一款产品均有相对应的资产，对借款企业信息进行详细的披露，同时对借款企业进行贷前、贷中、贷后管理。"
            model_0.title = "借款项目如何审核与管理？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "币优铺理财特聘北京长安（上海）律师事务所顶级律师事务所专家团与权威法律顾问团队,为币优铺理财商业模式的合法性、交易模式的合规性提供法律支持。"
            model_1.title = "平台是否有专业法律支持？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "币优铺理财六重还款来源，务必保障资金安全：\n一、原始债务企业为第一还款人，负有还款责任。\n二、当原始债务企业出现还款逾期时，原始债务企业的实际控制人承担无限连带保证责任，为第二还款人，负有还款责任。\n三、当第一、第二还款人出现还款逾期时，签订过商业保理协议业务的商业保理公司为第三还款人，负有还款责任。\n四、当以上还款人出现还款逾期时，签订过担保协议的担保公司为第四还款人，负有还款责任。\n五、当以上还款人出现还款逾期时，平台追索基于应收账款、票据融资的交易对手企业为第五还款人。\n六、银行账户千万级存款保障，逾期先行垫付，为平台用户提供最贴心和安全的服务。"
            model_2.title = "如果出现还款逾期，平台怎么保证投资者的利益？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "1.层层审核，仅筛选优质借款人。规范筛选优质项目，实地考核审查。\n2.全程监管，保障资金安全。贷后监控管理，签订法律协议。\n3.多重防线，有效抵御风险，快速专业催款，足额抵押变现。追缴清收。"
            model_3.title = "平台风控如何？"
            modelArray.append(model_3)
            
        } else if type == 3 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "进入“我的账户”，点击【充值】按钮，进入充值页面，选择支付方式，并输入相应的信息进行充值。"
            model_0.title = "如何充值？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "投资者充值免费，币优铺理财不收取手续费。"
            model_1.title = "充值是否收费？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "情况一、部分银行对单笔单天支出的金额有限制的。可参见网站上的银行信息。\n情况二、使用快捷支付方式也是有限额的。如果超过限额，可以使用网银支付。"
            model_2.title = "充值出现最高限额是怎么回事？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "使用快捷方式的情况下：\n情况一、掉单。即客户显示扣款，但是我们这边充值没有成功。此种情况下，一般是银行通信问题，第二天，未达成的交易会原路退回到客户账户的。\n情况二、充值延时。充值一般2分钟以内会到账，延时情况会半小时左右。\n\n使用网银充值的情况下：\n银行插件不兼容。需要清除浏览器缓存，安装好插件后，重启浏览器。"
            model_3.title = "充值失败怎么处理？"
            modelArray.append(model_3)
            
            //5.
            let model_4 = JSServiceCentreHotProblemDetailModel()
            model_4.detailTitle = "登录个人账户，打开“我的账户”，点击“我要取现”。"
            model_4.title = "如何提现？"
            modelArray.append(model_4)
            
            //6.
            let model_5 = JSServiceCentreHotProblemDetailModel()
            model_5.detailTitle = "当天下午4点之前提现，当天到账；下午4点后提现第二天到账。周末延期至下一个工作日。"
            model_5.title = "提现后什么时候到账？"
            modelArray.append(model_5)
            
            //7.
            let model_6 = JSServiceCentreHotProblemDetailModel()
            model_6.detailTitle = "每个月前两笔提现免手续费，之后每笔提现费用2元，不限金额大小。"
            model_6.title = "提现怎么收费？"
            modelArray.append(model_6)
            
            //8.
            let model_7 = JSServiceCentreHotProblemDetailModel()
            model_7.detailTitle = "为了保障平台用户的资金安全，用户在平台充值和提现必须使用同一张银行借记卡（即只能是用户注册时绑定的银行卡），不可以提现至别人的账户的。"
            model_7.title = "可以提现至别人的银行账户吗？"
            modelArray.append(model_7)
            
            //9.
            let model_8 = JSServiceCentreHotProblemDetailModel()
            model_8.detailTitle = "1. 提现的银行卡在平台预留的银行信息有误；\n2. 所绑定银行卡进行了注销。\n\n如不属上述情况，可咨询在线客服，询问具体原因。"
            model_8.title = "何种情况会造成提现失败？"
            modelArray.append(model_8)
            
            //10.
            let model_9 = JSServiceCentreHotProblemDetailModel()
            model_9.detailTitle = "投资人成功投标后是无法申请提前收款的。投资成功后，金额是有一个固定期限的，固定期结束后，才能获得返还。"
            model_9.title = "投资后能不能提前收款？"
            modelArray.append(model_9)
            
        } else if type == 4 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "成功注册投资即送588元新人专享投资红包。"
            model_0.title = "注册是否有红包？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "成功注册即送68888元体验金。"
            model_1.title = "成功注册是否有体验金？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "活动专区会推出优惠活动，将用户投资的利益最大化。"
            model_2.title = "平台是否有优惠活动？"
            modelArray.append(model_2)
            
        } else if type == 5 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "币优铺理财30天常规标：最低100元起投，按100元递增，投资成功后T+1日计息，投资周期是30天，到期一次性还本付息，预期基础年化利率6.5%，币优铺理财平台活动加息1%。"
            model_0.title = "币优铺理财的30天常规标是怎么样的产品，收益是多少？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "币优铺理财60天常规标：最低100元起投，按100元递增，投资成功后T+1日计息，投资周期是60天，到期一次性还本付息，预期基础年化利率7.5%，币优铺理财平台活动加息1%。"
            model_1.title = "币优铺理财的60天常规标是怎么样的产品，收益是多少？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "币优铺理财180天常规标：最低100元起投，按100元递增，投资成功后T+1日计息，投资周期是180天，到期一次性还本付息，预期基础年化利率9.5%，币优铺理财平台活动加息1%。"
            model_2.title = "币优铺理财的180天常规标是怎么样的产品，收益是多少？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "币优铺理财会不定期推出优惠活动，为用户推出优惠产品，使用户的收益最大化。用户可以随时关注平台活动。"
            model_3.title = "平台是否还有其他产品？"
            modelArray.append(model_3)
            
            //5.
            let model_4 = JSServiceCentreHotProblemDetailModel()
            model_4.detailTitle = "针对在币优铺理财注册的新用户，最低100元起投，投资周期是7天，预期基础年化利率12%，每位新用户仅有一次投资机会，单笔投资最高限额10000元。"
            model_4.title = "什么是新手标？"
            modelArray.append(model_4)
            
            
            //7.
            let model_6 = JSServiceCentreHotProblemDetailModel()
            model_6.detailTitle = "针对在币优铺理财注册的新用户，使用币优铺理财的体验金进行投资，标的为虚拟体验，可产生投资收益。体验金收益需要完成一次真实投资（新手标除外）后才可提现。"
            model_6.title = "什么是体验标？"
            modelArray.append(model_6)
            
        } else if type == 6 {
            
            //1.
            let model_0 = JSServiceCentreHotProblemDetailModel()
            model_0.detailTitle = "您可以利用闲钱、散钱进行投资理财，有效提升资金的流通和利用率，获得相应的收益回报（高于银行存款利息的收益）。"
            model_0.title = "成为币优铺理财会员有什么好处？"
            modelArray.append(model_0)
            
            //2.
            let model_1 = JSServiceCentreHotProblemDetailModel()
            model_1.detailTitle = "投标前请认真分析所投资标的详细信息（起投金额，年化利率，投资期限等），以确定您所要投的标符合您的风险承受能力和所要求的投资回报率。"
            model_1.title = "投标前需要注意什么？"
            modelArray.append(model_1)
            
            //3.
            let model_2 = JSServiceCentreHotProblemDetailModel()
            model_2.detailTitle = "目前平台暂时未收取佣金。"
            model_2.title = "投资是否收取佣金？"
            modelArray.append(model_2)
            
            //4.
            let model_3 = JSServiceCentreHotProblemDetailModel()
            model_3.detailTitle = "投资第二天开始计息，产品满标后第二天起息。"
            model_3.title = "投标后什么时候开始计息？"
            modelArray.append(model_3)
            
            //5.
            let model_4 = JSServiceCentreHotProblemDetailModel()
            model_4.detailTitle = "为了能够覆盖更多的合作银行，合作的第三方支付平台是富友。"
            model_4.title = "使用什么支付渠道？"
            modelArray.append(model_4)
            
            //6.
            let model_5 = JSServiceCentreHotProblemDetailModel()
            model_5.detailTitle = "1.点击登录页面的忘记密码链接。\n2.填写注册时使用的手机号码，点击获取验证码。\n3.输入发送到手机上的验证码及新设密码，完成重置密码。"
            model_5.title = "如何找回登录密码？"
            modelArray.append(model_5)
            
            //7.
            let model_6 = JSServiceCentreHotProblemDetailModel()
            model_6.detailTitle = "目前平台的还款方式有一种：“到期一次性还清本息”。"
            model_6.title = "平台目前有几种还款方式？"
            modelArray.append(model_6)
            
            //8.
            let model_7 = JSServiceCentreHotProblemDetailModel()
            model_7.detailTitle = " 情况：1. 页面不断加载 。 2.没有网络。 3.手机硬件和软件不兼容。\n解决方案：1.建议退出APP重新登录 2. 卸载APP重新下载安装  3.重启手机在网络环境好的情况下尝试 。\n若以上方法都不能解决，及时联系客服提交技术处理。"
            model_7.title = "APP软件出现闪退有哪些情况及解决方案？"
            modelArray.append(model_7)
        }
    }
}

class JSServiceCentreHotProblemDetailModel: NSObject {
    var isOpen: Bool = false //true打开，false关闭
    var detailTitle: String = "xxxx"
    var title: String = "xxxx?"
}
