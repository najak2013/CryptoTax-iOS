//
//  CoinDetailsViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class CoinDetailsViewController: UIViewController {

    let coinNameList = ["이더리움", "리플", "페이코인", "클레이튼", "코스모스아톰", "김지태", "크립토택스", "현대 자동차"]
    @IBOutlet weak var coinListCollectionView: UICollectionView!
    @IBOutlet weak var coinDetailsTableView: UITableView!
    
    
    var selectCoin: CoinInfo?
    var coinDetailsViewModel = CoinDetailsViewModel()
    var transactions: [Transactions]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinListCollectionView.dataSource = self
        coinListCollectionView.delegate = self
        coinDetailsTableView.rowHeight = UITableView.automaticDimension
        coinDetailsTableView.dataSource = self
        coinDetailsTableView.delegate = self
        
        let symbol = selectCoin?.ticker
        
        coinDetailsViewModel.getTransactionsData(symbol: symbol ?? "") { [weak self] in
            self?.transactions = self?.coinDetailsViewModel.transactions
            
            print(self?.transactions)
//            DispatchQueue.main.async {
//                self?.yearLabels.removeAll()
//                self?.transactionsContentTableView.reloadData()
//            }
        }
        
        cellRegister()
        
    }
    
    
    func cellRegister() {
        coinDetailsTableView.register(UINib(nibName: "CoinDetailGraphTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinDetailGraphTableViewCell")
        coinDetailsTableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
        coinDetailsTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        coinDetailsTableView.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
        coinDetailsTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        coinDetailsTableView.register(UINib(nibName: "TransactionsTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionsTableViewCell")
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CoinDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 4
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else if section == 6 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "CoinDetailGraphTableViewCell", for: indexPath) as! CoinDetailGraphTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 120
            cell.titleLabel.text = "이더리움을\n거래소 3곳에서 거래하셨어요"
            return cell
        } else if indexPath.section == 3 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
            return cell
        } else if indexPath.section == 4 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 5 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            return cell
        } else if indexPath.section == 6 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "TransactionsTableViewCell", for: indexPath) as! TransactionsTableViewCell
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension CoinDetailsViewController: UITableViewDelegate {
    
}

extension CoinDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = coinListCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinDetailsCollectionViewCell", for: indexPath) as! CoinDetailsCollectionViewCell
        cell.coinNameLabel.text = coinNameList[indexPath.row]
        return cell
        
    }
    
    
}

extension CoinDetailsViewController: UICollectionViewDelegate {
    
}


class CoinDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coinNameCell: UIView!
    @IBOutlet weak var coinNameLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        coinNameCell.layer.cornerRadius = coinNameCell.layer.frame.height / 2
        coinNameCell.clipsToBounds = true
        }
}
