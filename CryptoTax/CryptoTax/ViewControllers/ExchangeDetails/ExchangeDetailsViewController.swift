//
//  ExchangeDetailsViewController.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/24.
//

import UIKit

class ExchangeDetailsViewController: UIViewController {

    var exchange: Exchange?
    
    @IBOutlet weak var exchangeDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeDetailsTableView.rowHeight = UITableView.automaticDimension
        exchangeDetailsTableView.dataSource = self
        exchangeDetailsTableView.delegate = self
        cellRegister()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func cellRegister() {
        exchangeDetailsTableView.register(UINib(nibName: "ExchangeDetailsGraphTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeDetailsGraphTableViewCell")
        exchangeDetailsTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        exchangeDetailsTableView.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
        exchangeDetailsTableView.register(UINib(nibName: "AddExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "AddExchangeTableViewCell")
    }
    @IBAction func transactionsListButton(_ sender: Any) {
        guard let transactionsVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionsViewController") as? TransactionsViewController else { return }
        guard let exchangeName = exchange?.name?.en else { return }
        let name = exchangeName
        print(name)
        transactionsVC.exchanges = exchangeName.lowercased()
        self.navigationController?.pushViewController(transactionsVC, animated: true)
    }
}

extension ExchangeDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 4
        } else if section == 3 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = exchangeDetailsTableView.dequeueReusableCell(withIdentifier: "ExchangeDetailsGraphTableViewCell", for: indexPath) as! ExchangeDetailsGraphTableViewCell
            guard let thumbnail = exchange?.thumbnail else { return UITableViewCell() }
            guard let exchangeName = exchange?.name else { return UITableViewCell() }
            
    //        guard let ticker = selectedCoin?.ticker else { return UITableViewCell() }
    //        guard let valuationPrice = selectedCoin?.valuationPrice else { return UITableViewCell() }
    //        guard let purchasePrice = selectedCoin?.purchasePrice else { return UITableViewCell() }
    //        guard let amount = selectedCoin?.amount else { return UITableViewCell() }
    //
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
    //
    //
            cell.thumbnailImageView.image = UIImage(data: data)
            let name: String = exchangeName.ko ?? exchangeName.en ?? "error"
            cell.titleLabel.text = "\(name)·총 거래금액"
    //        cell.valuationPriceLabel.text = valuationPrice.insertComma + "원"
    //        cell.purchasePriceLabel.text = purchasePrice.insertComma + "원"
    //        cell.amountLabel.text = amount + ticker
    //
            return cell
        } else if indexPath.section == 1 {
            let cell = exchangeDetailsTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 92
            cell.titleLabel.text = "거래자산"
            return cell
        } else if indexPath.section == 2 {
            let cell = exchangeDetailsTableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
            cell.exchangeNameLabel.isHidden = true
            cell.valuationPriceLabelBottomConstraint.constant = 30
            return cell
        } else if indexPath.section == 3 {
            let cell = exchangeDetailsTableView.dequeueReusableCell(withIdentifier: "AddExchangeTableViewCell", for: indexPath) as! AddExchangeTableViewCell
            cell.addExchangeButton.addTarget(self, action: #selector(addExchange), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func addExchange() {
        guard let addExchangeVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeConnectionViewController") as? ExchangeConnectionViewController else { return }
//        addExchangeVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(addExchangeVC, animated: true)
    }
}

extension ExchangeDetailsViewController: UITableViewDelegate {

}
