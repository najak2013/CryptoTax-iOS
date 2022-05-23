//
//  TransactionsViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class TransactionsViewController: UIViewController {

    
    
    @IBOutlet weak var transactionsContentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        
    }
    
}
