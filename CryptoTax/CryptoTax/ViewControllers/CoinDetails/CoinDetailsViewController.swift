//
//  CoinDetailsViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import UIKit

class CoinDetailsViewController: UIViewController {

    @IBOutlet weak var coinListCollectionView: UICollectionView!
    @IBOutlet weak var coinDetailsTableView: UITableView!
    
    // 화면을 그리기 위한 변수들
    // 초기화 필요
    var selectedCoin: CoinInfo?
    // 초기화 필요
    var transactions: [Transactions]?
    // 초기화 필요
    var symbol: String = ""
    // 초기화 필요
    var yearLabels: [String : Int] = [:]
    // 초기화 필요
    var dateLabels: [String : Int] = [:]
    // 초기화 필요
    var exchanges: [Exchange]?
    // 초기화 필요
    var summary: Summary?
    
    
    
    var coinDetailsViewModel = CoinDetailsViewModel()
    var symbolList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinListCollectionView.dataSource = self
        coinListCollectionView.delegate = self
        coinDetailsTableView.rowHeight = UITableView.automaticDimension
        coinDetailsTableView.dataSource = self
        coinDetailsTableView.delegate = self
        cellRegister()
        symbol = selectedCoin?.ticker ?? ""
        getConnections()
    }
    
    //MARK: - 초기화
    func getConnections() {
//        yearLabels.removeAll()
//        dateLabels.removeAll()
            
        
        let parameters: [String : String] = ["section":"month", "duration": "3M", "symbol": symbol, "price_type": "profit"]
        
        coinDetailsViewModel.getCoinBalanceData(symbol: symbol, parameters: parameters) { [weak self] in
            self?.selectedCoin = self?.coinDetailsViewModel.selectedCoin
            self?.exchanges = self?.coinDetailsViewModel.exchanges
            self?.summary = self?.coinDetailsViewModel.summary
            DispatchQueue.main.async {
                self?.coinDetailsTableView.reloadData()
                self?.coinListCollectionView.reloadData()
            }
        }
        
        coinDetailsViewModel.getTransactionsData(symbol: symbol) { [weak self] in
            self?.transactions = self?.coinDetailsViewModel.transactions
            DispatchQueue.main.async {
                self?.coinDetailsTableView.reloadData()
                self?.coinListCollectionView.reloadData()
            }
        }
    }
    
    
    func cellRegister() {
        coinDetailsTableView.register(UINib(nibName: "CoinDetailGraphTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinDetailGraphTableViewCell")
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            let count: Int = exchanges?.count ?? 0
            return count
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return transactions?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "CoinDetailGraphTableViewCell", for: indexPath) as! CoinDetailGraphTableViewCell
            guard let thumbnail = selectedCoin?.thumbnail else { return UITableViewCell() }
            guard let coinName = selectedCoin?.name else { return UITableViewCell() }
            guard let ticker = selectedCoin?.ticker else { return UITableViewCell() }
            guard let valuationPrice = selectedCoin?.valuationPrice else { return UITableViewCell() }
            guard let purchasePrice = selectedCoin?.purchasePrice else { return UITableViewCell() }
            guard let amount = selectedCoin?.amount else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            let name: String = coinName.ko ?? coinName.en ?? "error"
            cell.coinNameLabel.text = "\(name)·\(ticker)"
            cell.valuationPriceLabel.text = valuationPrice.insertComma + "원"
            cell.purchasePriceLabel.text = purchasePrice.insertComma + "원"
            cell.amountLabel.text = amount + ticker
            
            return cell
        } else if indexPath.section == 1 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 120
            
            guard let coinName = selectedCoin?.name else { return UITableViewCell() }
            let name: String = coinName.ko ?? coinName.en ?? "error"
            let count: Int = exchanges?.count ?? 0
            cell.titleLabel.text = "\(name)을\n거래소 \(count)곳에서 거래하셨어요"
            return cell
        } else if indexPath.section == 2 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
            guard let exchange = exchanges?[indexPath.row] else { return UITableViewCell() }
            guard let exchangethumbnail = exchange.thumbnail else { return UITableViewCell() }
            guard let exchangeName = exchange.name else { return UITableViewCell() }
            guard let exchangeAmount = exchange.amount else { return UITableViewCell() }
            guard let exchangeYield = exchange.yield else { return UITableViewCell() }
            
            let url = URL(string: exchangethumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.valuationPriceLabel.text = exchangeAmount + " "
            cell.exchangeNameLabel.text = exchangeName.ko ?? exchangeName.en ?? "Error"
            
            var doubleYield = Double(exchangeYield) ?? 0
            if doubleYield >= 0 {
                cell.yieldLabel.textColor = UIColor(red: 0.8667, green: 0.3216, blue: 0.3412, alpha: 1.0)
            } else {
                doubleYield = (doubleYield * -1)
                cell.yieldLabel.textColor = UIColor(red: 0.2824, green: 0.502, blue: 0.9333, alpha: 1.0)
            }
            cell.yieldLabel.text = "\(doubleYield * 100)"
            
            return cell
        } else if indexPath.section == 3 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            cell.cellHeightConstraint.constant = 76
            return cell
        } else if indexPath.section == 4 {
            let cell = coinDetailsTableView.dequeueReusableCell(withIdentifier: "TransactionsTableViewCell", for: indexPath) as! TransactionsTableViewCell
            // 시간
            guard let doneAtKst = transactions?[indexPath.row].doneAtKst else { return UITableViewCell() }
            // 주문 화폐
            guard let orderCurrency = transactions?[indexPath.row].orderCurrency else { return UITableViewCell() }
            // 양
            guard var amount = transactions?[indexPath.row].amount else { return UITableViewCell() }
            // side
            guard let sideString = transactions?[indexPath.row].sideString else { return UITableViewCell() }
            // 교환소 이름
            guard let exchangeNameKoEn = transactions?[indexPath.row].exchangeName else { return UITableViewCell() }
            
            let orderName = exchangeNameKoEn.ko ?? exchangeNameKoEn.en ?? "error"
//            let exchangeName = exchangeNameKoEn.ko ?? exchangeNameKoEn.en ?? "error"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:m:s" // 2020-08-13 16:30
                    
            let convertDate = dateFormatter.date(from: doneAtKst) // Date 타입으로 변환
                    
            let yearDateFormatter = DateFormatter()
            let dateDateFormatter = DateFormatter()
            let timeDateFormatter = DateFormatter()
            yearDateFormatter.dateFormat = "yyyy년"
            dateDateFormatter.dateFormat = "M월 d일"
            timeDateFormatter.dateFormat = "HH:mm"
            
            let year = yearDateFormatter.string(from: convertDate!)
            let date = dateDateFormatter.string(from: convertDate!)
            let time = timeDateFormatter.string(from: convertDate!)
            
            
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
            cell.sideStringAndOthersLabel.text = "\(sideString) | \(time)"
            
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

extension CoinDetailsViewController: UITableViewDelegate {
    
}

extension CoinDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let coinName: String = symbolList[indexPath.row].last {
            let cell = coinListCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinDetailsCollectionViewCell", for: indexPath) as! CoinDetailsCollectionViewCell
            if symbol == symbolList[indexPath.row].first {
                cell.coinNameCell.backgroundColor = UIColor(red: 0.2078, green: 0.2353, blue: 0.2863, alpha: 1.0)
                cell.coinNameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            } else {
                cell.coinNameCell.backgroundColor = UIColor(red: 0.949, green: 0.9569, blue: 0.9647, alpha: 1.0)
                cell.coinNameLabel.textColor = UIColor(red: 0.2078, green: 0.2353, blue: 0.2863, alpha: 1.0)
            }
            
            cell.coinNameLabel.text = coinName
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CoinDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        symbol = symbolList[indexPath.row].first ?? ""
        getConnections()
    }
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
