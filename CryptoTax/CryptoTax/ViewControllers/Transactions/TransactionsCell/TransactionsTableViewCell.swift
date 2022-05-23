//
//  TransactionsTableViewCell.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var sideStringAndExchangeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var feeView: UIView!
    @IBOutlet weak var amountLabeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
