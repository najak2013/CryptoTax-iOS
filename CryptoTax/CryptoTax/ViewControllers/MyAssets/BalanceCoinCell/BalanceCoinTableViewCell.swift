//
//  FinishedCoinTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import UIKit

class BalanceCoinTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var valuationPriceLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
