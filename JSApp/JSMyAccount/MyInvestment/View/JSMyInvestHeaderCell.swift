//
//  JSMyInvestHeaderCell.swift
//  JSApp
//
//  Created by Feng Lu on 2017/2/23.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

import UIKit

class JSMyInvestHeaderCell: UITableViewCell {
    @IBOutlet weak var investingLabel: UILabel!     //在投资产
    @IBOutlet weak var beReceivedLabel: UILabel!    //待收本金
    @IBOutlet weak var totalInterestLabel: UILabel!     //待收总利息
    
    //赋值数据
    func configModel(_ model:MyInvestMapModel)
    {
        investingLabel.text = PD_NumDisplayStandard.numDisplayStandard(String(format: "%.2f", model.principal + model.interest),decimalPointType: 1, numVerification: false)
        
        beReceivedLabel.text = PD_NumDisplayStandard.numDisplayStandard(String(format: "%.2f", model.principal),decimalPointType: 1, numVerification: false)
        
        totalInterestLabel.text = PD_NumDisplayStandard.numDisplayStandard(String(format: "%.2f", model.interest),decimalPointType: 1, numVerification: false)
    }
    
    class func cellHeight()-> CGFloat
    {
//        return 90 * SCREEN_SCALE_W
        return 75 * SCREEN_SCALE_W
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
