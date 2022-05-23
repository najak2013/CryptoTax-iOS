//
//  TopMsgTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class TopMsgTableViewCell: UITableViewCell {

    @IBOutlet weak var topMsgLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topMsgLabel.asColor(target: "최대 10분", color: UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
