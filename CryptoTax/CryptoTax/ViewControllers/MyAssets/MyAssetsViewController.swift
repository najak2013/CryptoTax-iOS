//
//  MyAssetsViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit
import CryptoSwift

class MyAssetsViewController: BaseViewController {

    @IBOutlet weak var AssetsContentTableView: UITableView!
    
    let spaceBetweenSections = 100.0
    
    var myAssetsViewModel = MyAssetsViewModel()
    
    var airDropCount: Int = 0
    var runningCount: Int = 0
    var finishedCount: Int = 0
    
    var totalCoinCount: Int = 0
    
    var finishedCoin: [CoinInfo]?
    var airDropCoin: [CoinInfo]?
    var runningCoin: [CoinInfo]?
    
    var coinRatio: [Dictionary<String, Double>.Element]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AssetsContentTableView.rowHeight = UITableView.automaticDimension
        AssetsContentTableView.dataSource = self
        AssetsContentTableView.delegate = self
        cellRegister()
        
        myAssetsViewModel.getCoinBalanceData { [weak self] in
            self?.airDropCount = self?.myAssetsViewModel.airDropCount ?? 0
            self?.runningCount = self?.myAssetsViewModel.runningCount ?? 0
            self?.finishedCount = self?.myAssetsViewModel.finishedCount ?? 0
            
            self?.totalCoinCount = self?.myAssetsViewModel.totalCoinCount ?? 0
            
            self?.finishedCoin = self?.myAssetsViewModel.finishedCoin
            self?.airDropCoin = self?.myAssetsViewModel.airDropCoin
            self?.runningCoin = self?.myAssetsViewModel.runningCoin
            
            self?.coinRatio = self?.myAssetsViewModel.coinRatio
            
            DispatchQueue.main.async {
                self?.AssetsContentTableView.reloadData()
            }
        }
    }
    
    
    
    
    func cellRegister() {
        AssetsContentTableView.register(UINib(nibName: "GraphTableViewCell", bundle: nil), forCellReuseIdentifier: "GraphTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "BalanceCoinTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceCoinTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "LineTableViewCell", bundle: nil), forCellReuseIdentifier: "LineTableViewCell")
    }
}

extension MyAssetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //MARK: - 그래프 그려지는 Cell
            return 1
        } else if section == 1 {
            //MARK: - Cell 사이 간격
            return 1
        } else if section == 2 {
            //MARK: - 코인별 Title
            return 1
        } else if section == 3 {
            //MARK: - 코인별 리스트 컨트롤러
            return 1
        } else if section == 4 {
            //MARK: - Finished Coin
            return finishedCount
        } else if section == 5 {
            //MARK: - 구분선
            if airDropCount > 0 {
                return 1
            } else {
                return 0
            }
        } else if section == 6 {
            //MARK: - 에어드랍 리스트
            return airDropCount
        } else if section == 7 {
            //MARK: - 준비중 리스트
            return runningCount
        } else if section == 8 {
            //MARK: - Cell 사이 간격
            return 1
        } else if section == 9 {
            //MARK: - 코인별 Title
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: - 그래프 그려지는 Cell
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as! GraphTableViewCell
            return cell
        } else if indexPath.section == 1 {
            //MARK: - Cell 사이 간격
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 2 {
            //MARK: - 코인별 Title
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "총 \(totalCoinCount)개의 자산을\n가지고 있어요"
            return cell
        } else if indexPath.section == 3 {
            //MARK: - 코인별 리스트 컨트롤러
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            return cell
        } else if indexPath.section == 4 {
            //MARK: - Finished Coin
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = finishedCoin?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = finishedCoin?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = finishedCoin?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = finishedCoin?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = finishedCoin?[indexPath.row].valuationPrice else { return UITableViewCell() }
            guard let yield = finishedCoin?[indexPath.row].yield else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = valuationPrice
            
            var printYield: Double = Double(yield) ?? 0
            if printYield >= 0 {
                cell.yieldLabel.textColor = UIColor(red: 0.8667, green: 0.3216, blue: 0.3412, alpha: 1.0)
            } else {
                printYield = (printYield * -1)
                cell.yieldLabel.textColor = UIColor(red: 0.2824, green: 0.502, blue: 0.9333, alpha: 1.0)
            }
            cell.yieldLabel.text = "\(printYield * 100)%"
            return cell
        } else if indexPath.section == 5 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "LineTableViewCell", for: indexPath) as! LineTableViewCell
            return cell
        } else if indexPath.section == 6 {
            //MARK: - AirDrop Coin
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = airDropCoin?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = airDropCoin?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = airDropCoin?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = airDropCoin?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = airDropCoin?[indexPath.row].valuationPrice else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = valuationPrice
            cell.yieldLabel.textColor = UIColor(red: 0.6941, green: 0.7216, blue: 0.7529, alpha: 1.0)
            cell.yieldLabel.text = "에어드랍"
            return cell
        } else if indexPath.section == 7 {
            //MARK: - Running Coin
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = runningCoin?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = runningCoin?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = runningCoin?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = runningCoin?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = runningCoin?[indexPath.row].valuationPrice else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = valuationPrice
            cell.yieldLabel.textColor = UIColor(red: 0.6941, green: 0.7216, blue: 0.7529, alpha: 1.0)
            cell.yieldLabel.text = "수집중..."
            return cell
        } else if indexPath.section == 8 {
            //MARK: - Cell 사이 간격
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 9 {
            //MARK: - 코인별 Title
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            guard let coin = coinRatio?[0].key else { return UITableViewCell() }
                    
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "\(coin)에\n관심이 많으시네요"
            return cell
        }
        return UITableViewCell()
    }
}

extension MyAssetsViewController: UITableViewDelegate {
}

