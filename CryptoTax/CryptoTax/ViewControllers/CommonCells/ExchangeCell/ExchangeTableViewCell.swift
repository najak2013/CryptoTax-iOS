//
//  ExchangeTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/22.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var valuationPriceLabel: UILabel!
    @IBOutlet weak var exchangeNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
