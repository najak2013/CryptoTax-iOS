//
//  TransactionsViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class TransactionsViewController: UIViewController {

    
    
    @IBOutlet weak var transactionsContentTableView: UITableView!
    
    
    var transactionsViewModel = TransactionsViewModel()
    var transactions: [Transactions]?
    var yearLabels: [String : Int] = [:]
    var dateLabels: [String : Int ] = [:]
    
    
    var exchanges: String = ""
    var symbol: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsContentTableView.dataSource = self
        transactionsContentTableView.delegate = self
        
        cellRegister()
        
        
        transactionsViewModel.getTransactionsData(exchanges: exchanges, symbol: symbol, start_date: "", sort_order: "", skip: "", limit: "") { [weak self] in
            self?.transactions = self?.transactionsViewModel.transactions
            DispatchQueue.main.async {
                self?.transactionsContentTableView.reloadData()
            }
            
        }
    }
    
    func cellRegister() {
        transactionsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        transactionsContentTableView.register(UINib(nibName: "TopMsgTableViewCell", bundle: nil), forCellReuseIdentifier: "TopMsgTableViewCell")
        transactionsContentTableView.register(UINib(nibName: "TransactionsTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionsTableViewCell")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TransactionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return transactions?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: - 그래프 그려지는 Cell
            let cell = transactionsContentTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            cell.cellHeightConstraint.constant = 60
            return cell
        } else if indexPath.section == 1 {
            let cell = transactionsContentTableView.dequeueReusableCell(withIdentifier: "TopMsgTableViewCell", for: indexPath) as! TopMsgTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = transactionsContentTableView.dequeueReusableCell(withIdentifier: "TransactionsTableViewCell", for: indexPath) as! TransactionsTableViewCell
            
            guard let doneAtKst = transactions?[indexPath.row].doneAtKst else { return UITableViewCell() }
            guard let orderCurrency = transactions?[indexPath.row].orderCurrency else { return UITableViewCell() }
            guard var amount = transactions?[indexPath.row].amount else { return UITableViewCell() }
            guard let orderNameKoEn = transactions?[indexPath.row].orderName else { return UITableViewCell() }
            guard let sideString = transactions?[indexPath.row].sideString else { return UITableViewCell() }
            guard let exchangeNameKoEn = transactions?[indexPath.row].exchangeName else { return UITableViewCell() }
            
            
            let orderName = orderNameKoEn.ko ?? orderNameKoEn.en ?? "error"
            let exchangeName = exchangeNameKoEn.ko ?? exchangeNameKoEn.en ?? "error"
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:m:s" // 2020-08-13 16:30
                    
            let convertDate = dateFormatter.date(from: doneAtKst) // Date 타입으로 변환
                    
            let yearDateFormatter = DateFormatter()
            let dateDateFormatter = DateFormatter()
            yearDateFormatter.dateFormat = "yyyy년"
            dateDateFormatter.dateFormat = "M월 d일"
            
            let year = yearDateFormatter.string(from: convertDate!)
            let date = dateDateFormatter.string(from: convertDate!)
            
            if yearLabels.keys.contains(year) {
                if indexPath.row == yearLabels[year] {
                    cell.cellHeightConstraint.constant = 197
                } else {
                    if dateLabels.keys.contains(date) {
                        if indexPath.row == dateLabels[date] {
                            cell.cellHeightConstraint.constant = 137
                        } else {
                            cell.cellHeightConstraint.constant = 80
                        }
                    } else {
                        cell.cellHeightConstraint.constant = 137
                        dateLabels[date] = indexPath.row
                    }
                }
            } else {
                yearLabels[year] = indexPath.row
                if dateLabels.keys.contains(date) {
                    if indexPath.row == dateLabels[date] {
                        cell.cellHeightConstraint.constant = 137
                    } else {
                        cell.cellHeightConstraint.constant = 80
                    }
                } else {
                    dateLabels[date] = indexPath.row
                }
            }
            
            
            
            
            cell.yearLabel.text = year
            cell.dateLabel.text = date
            cell.orderName.text = orderName
            
            if let fee = transactions?[indexPath.row].fees {
                cell.feeView.isHidden = false
                cell.amountLabeTopConstraint.constant = 20
                if sideString == "출금" {
                    cell.feeLabel.text = fee.insertComma + orderCurrency
                } else {
                    cell.feeLabel.text = fee.insertComma + "원"
                }
            } else {
                cell.feeView.isHidden = true
                cell.amountLabeTopConstraint.constant = 30
            }
            if exchanges != "" {
                cell.sideStringAndOthersLabel.text = "\(sideString)"
            } else {
                cell.sideStringAndOthersLabel.text = "\(sideString) | \(exchangeName)"
            }
            
            
            let icoBuySeq: [String] = ["출금(스테이킹)", "출금", "판매"]
            
            if icoBuySeq.contains(sideString) {
                cell.tradeIcon.image = UIImage(named: "ico_sell")
            } else {
                cell.tradeIcon.image = UIImage(named: "ico_buy")
            }
            
            if orderCurrency == "KRW" {
                amount = amount.insertComma + " 원"
            } else {
                amount = amount + " " + orderCurrency
            }
            cell.amountLabel.text = amount
            
            
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension TransactionsViewController: UITableViewDelegate {
    
}
