//
//  JSInvestProductListHomeCell.swift
//  JSApp
//
//  Created by Feng Lu on 2017/4/20.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSInvestProductListHomeCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var addRateLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var titleBackgroundView: UIView!  //顶部背景视图
    
    var pertProgressView: KDCircularProgress!    //募集进度的圆圈
    var pertLabel: UILabel!                      //募集进度
    var labelsView: JSDisplayLabelsView?
    var titleArray: [TitleModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupChildUI()
    }

    func refreshView(_ model: InvestmentRowModel?) {
        
        titleLabel.text = model?.fullName!
        
        //利率
        let rate = PD_NumDisplayStandard.numDisplayStandard("\((model?.rate)!)", decimalPointType: 1, numVerification: false)
        self.setAttributedString(rate! + "%", subString: "%", attributeName: NSFontAttributeName, isSetFont: true, font: 13, location: (rate?.characters.count)!,length:"%".characters.count,label:rateLabel)
        
        //活动利率
        if model!.activityRate != 0 {
            let addRate = "+" + PD_NumDisplayStandard.numDisplayStandard("\(model!.activityRate)", decimalPointType: 1, numVerification: false)
            self.setAttributedString(addRate + "%", subString: "%", attributeName: NSFontAttributeName, isSetFont: true, font: 13, location: addRate.characters.count, length: "%".characters.count, label: addRateLabel)
        }
        else
        {
            addRateLabel.text = ""
        }
        
        //期限
        deadlineLabel.text = "\((model?.deadline)!)天"
        self.setAttributedString(deadlineLabel.text!, subString: "天", attributeName: NSFontAttributeName, isSetFont: true, font: 13, location: deadlineLabel.text!.characters.count - "天".characters.count, length: "天".characters.count, label: deadlineLabel)
        
        print("输出\(model?.isCash)==\(model?.isInterest)==\(model?.isDouble)==\(model!.id)")
        
        
        self.pertProgressView.angle = 0
        self.pertProgressView.animateToAngle((Int)(model!.pert * 3.60), duration: 1, completion: nil)
        
        self.pertProgressView.trackColor = DEFAULT_PROCOLOR//底部圈颜色
        self.pertProgressView.progressColors = [DEFAULT_TRACK]
        
        if model!.status != 5
        {
            self.pertLabel.textColor             = TITLE_GRAYCOLOR
            titleLabel.textColor = Default_All6_Color
            rateLabel.textColor = DEFAULT_ORANGECOLOR
            addRateLabel.textColor = DEFAULT_ORANGECOLOR
            deadlineLabel.textColor = Default_Deadline_Color
            
            if model!.status == 6 {
                self.pertLabel.text = "抢完了"
                var newLabelFrame = self.pertLabel.frame
                newLabelFrame.size.width = 44
                newLabelFrame.origin.x = self.pertProgressView.frame.origin.x + (self.pertProgressView.frame.width - 44) / 2
                self.pertLabel.frame = newLabelFrame
                
            } else if model!.status == 8 {
                self.pertLabel.text = "待还款" //已计息
                var newLabelFrame = self.pertLabel.frame
                newLabelFrame.size.width = 80
                newLabelFrame.origin.x = self.pertProgressView.frame.origin.x + (self.pertProgressView.frame.width - 80) / 2
                self.pertLabel.frame = newLabelFrame
            } else if model!.status == 9 {
                self.pertLabel.text = "已还款"
                var newLabelFrame = self.pertLabel.frame
                newLabelFrame.size.width = 80
                newLabelFrame.origin.x = self.pertProgressView.frame.origin.x + (self.pertProgressView.frame.width - 80) / 2
                self.pertLabel.frame = newLabelFrame
            } else {
                self.pertLabel.text = ""
                var newLabelFrame = self.pertLabel.frame
                newLabelFrame.size.width = 80
                newLabelFrame.origin.x = self.pertProgressView.frame.origin.x + (self.pertProgressView.frame.width - 80) / 2
                self.pertLabel.frame = newLabelFrame
            }
        }
        else
        {
            var newLabelFrame = self.pertLabel.frame
            newLabelFrame.size.width = 80
            newLabelFrame.origin.x = self.pertProgressView.frame.origin.x + (self.pertProgressView.frame.width - 80) / 2
            self.pertLabel.frame = newLabelFrame
            self.pertLabel.textColor = JS_REDCOLOR
            
            titleLabel.textColor = Default_All3_Color
            
            rateLabel.textColor = DEFAULT_ORANGECOLOR
            addRateLabel.textColor = DEFAULT_ORANGECOLOR
            deadlineLabel.textColor = Default_All6_Color
            
            if model!.pert >= 99.00 && model!.pert < 100.00 {
                self.pertLabel.text = "去抢购"
            } else {
                self.pertLabel.text = "去抢购"
            }
        }
        
        //配置优惠券
        var array = [TitleModel]()
        
        if (model?.isCash)! == 1 {
            let model = TitleModel()
            model.title = "红包"
            array.append(model)
        }
        
        if (model?.isInterest)! == 1 {
            let model = TitleModel()
            model.title = "加息券"
            array.append(model)
        }
        
        if (model?.isDouble)! == 1 {
            let model = TitleModel()
            model.title = "翻倍券"
            array.append(model)
        }
        
        if array.count > 0 {
            self.configureDisplayLabelsView(array)
        }
        
    }
    
    func configureDisplayLabelsView(_ array: [TitleModel]) {
        
        let view = JSDisplayLabelsView()
        view.labelFont = 11
        view.labelTextColor = DEFAULT_ORANGECOLOR
        view.margin = 7
        view.configureView(array)
        titleBackgroundView.addSubview(view)
        
        self.titleArray = array
        self.labelsView = view
        
        self.layoutIfNeeded()
    }
    
    //MARK: 创建UI
    func setupChildUI()
    {
        //        pertProgressView = KDCircularProgress(frame: CGRectMake(SCREEN_WIDTH - (70 * SCREEN_SCALE_W), 45 * SCREEN_SCALE_W, 60 * SCREEN_SCALE_W, 60 * SCREEN_SCALE_W))
        pertProgressView = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: self.progressView.width, height: self.progressView.height))
        pertProgressView.trackThickness = 0.25
        pertProgressView.progressThickness = 0.25
        pertProgressView.startAngle = -90
        pertProgressView.glowAmount = 0
        pertProgressView.trackColor = DEFAULT_TRACK//底部圈颜色
        pertProgressView.progressColors = [DEFAULT_PROCOLOR]
        progressView.addSubview(pertProgressView!)
        
        pertLabel = UILabel(frame: pertProgressView.frame)
        pertLabel.textAlignment = NSTextAlignment.center
        pertLabel.font = UIFont.systemFont(ofSize: 11)
        pertLabel.numberOfLines = 2
        pertLabel.text = "去抢购"
        pertLabel.textColor = JS_REDCOLOR
        progressView.addSubview(pertLabel!)
        
    }
    
    //设置Attribute
    func setAttributedString(_ superString:String,subString:String,attributeName:String,isSetFont:Bool,font:CGFloat,location:Int,length:Int,label:UILabel)
    {
        let attributedString = NSMutableAttributedString(string: superString)
        if isSetFont
        {
            attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: font), range: NSMakeRange(location,length))
        }
        label.attributedText = attributedString
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        if self.labelsView != nil {
            
            let view_width = JSDisplayLabelsView.getWidth(titleArray,
                                                          margin: 7,
                                                          labelFont: 11,
                                                          viewHeight: 18,
                                                          margin_title: 5)
            
            self.labelsView!.frame = CGRect(x: self.titleLabel.frame.maxX + 5,y: 15.5, width: view_width, height: 18)
            //超过部分隐藏
            self.labelsView?.layoutSubTitleLabelWithDisplayWidth(SCREEN_WIDTH - self.titleLabel.frame.maxX, viewHeight: 18)
        }
    }
    
}
