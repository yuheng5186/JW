//
//  HomeSecondCell.swift
//  JSApp
//
//  Created by Feng Lu on 2017/2/8.
//  Copyright © 2017年 wangyuxi. All rights reserved.
//

import UIKit

class HomeSecondCell: UITableViewCell {
    
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftContentLabel: UILabel!
    
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightContentLabel: UILabel!

    var homeSafetyClick:(()->())!
    var homeHotActivityClick:(()->())!
    
    func setupModel(_ model:HomeMapModel?)
    {

        leftTitleLabel.text = "安全保障"
        leftContentLabel.text = "六大还款来源"

        rightTitleLabel.text = "邀请好友"
        rightContentLabel.text = "丰厚利润享不停"
    }
    
    //安全保障
    @IBAction func safetyClick(_ sender: UIButton) {
        self.homeSafetyClick()
    }
    //热门活动
    @IBAction func hotActivityClick(_ sender: UIButton) {
        self.homeHotActivityClick()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
