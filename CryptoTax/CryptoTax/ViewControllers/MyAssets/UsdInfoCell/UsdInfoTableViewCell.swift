//
//  UsdInfoTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/22.
//

import UIKit

class UsdInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var valueOfChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
