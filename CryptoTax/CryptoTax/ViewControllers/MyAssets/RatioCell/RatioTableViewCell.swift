//
//  RatioTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/21.
//

import UIKit

class RatioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinColorView: UIView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinRatioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
