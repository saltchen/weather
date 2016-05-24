//
//  WeekCell.swift
//  SZWeather
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell {
    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var labelLowTemp: UILabel!
    @IBOutlet weak var labelHighTemp: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
