//
//  AttachCell.swift
//  SZWeather
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class AttachCell: UITableViewCell {
    @IBOutlet weak var labelHumid: UILabel!
    @IBOutlet weak var labelWind: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
