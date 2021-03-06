//
//  MyAssetsViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit
import CryptoSwift

class MyAssetsViewController: BaseViewController {

    @IBOutlet weak var assetsContentTableView: UITableView!
    
    
    var myAssetsViewModel = MyAssetsViewModel()
    var addExchangeViewModel = AddExchangeViewModel()
    
    var airDropCount: Int = 0
    var runningCount: Int = 0
    var finishedCount: Int = 0
    
    var totalCoinCount: Int = 0
    
    var finishedCoins: [CoinInfo]?
    var airDropCoins: [CoinInfo]?
    var runningCoins: [CoinInfo]?
    
    var coinRatio: [Dictionary<String, Double>.Element] = []
    
    var exchanges: [Exchange]?
    var exchangesCount: Int = 0
    var usdInfo: UsdInfo?
    
    var totalAsset: Int = 0
    var yield: Double = 0.0
    var revenueAmount: Int = 0
    var avgBuyPrice: Double = 0.0
    var collectionStartEnd: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assetsContentTableView.rowHeight = UITableView.automaticDimension
        assetsContentTableView.dataSource = self
        assetsContentTableView.delegate = self
        cellRegister()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myAssetsViewModel.getGraphData { [weak self] in
            self?.totalAsset = self?.myAssetsViewModel.totalAsset ?? 0
            self?.yield = self?.myAssetsViewModel.yield ?? 0.0
            self?.revenueAmount = self?.myAssetsViewModel.revenueAmount ?? 0
            self?.avgBuyPrice = self?.myAssetsViewModel.avgBuyPrice ?? 0.0
            self?.collectionStartEnd = self?.myAssetsViewModel.collectionStartEnd ?? "준비중..."
            DispatchQueue.main.async {
                self?.assetsContentTableView.reloadData()
            }
        }
        
        myAssetsViewModel.getCoinBalanceData { [weak self] in
            self?.airDropCount = self?.myAssetsViewModel.airDropCount ?? 0
            self?.runningCount = self?.myAssetsViewModel.runningCount ?? 0
            self?.finishedCount = self?.myAssetsViewModel.finishedCount ?? 0
            
            self?.totalCoinCount = self?.myAssetsViewModel.totalCoinCount ?? 0
            
            self?.finishedCoins = self?.myAssetsViewModel.finishedCoin
            self?.airDropCoins = self?.myAssetsViewModel.airDropCoin
            self?.runningCoins = self?.myAssetsViewModel.runningCoin
            
            self?.coinRatio = self?.myAssetsViewModel.coinRatio ?? []
            
            DispatchQueue.main.async {
                self?.assetsContentTableView.reloadData()
            }
        }
        
        myAssetsViewModel.getExchangeBalanceData { [weak self] in
            self?.exchanges = self?.myAssetsViewModel.exchanges
            self?.exchangesCount = self?.myAssetsViewModel.exchangesCount ?? 0
            self?.usdInfo = self?.myAssetsViewModel.usdInfo
            DispatchQueue.main.async {
                self?.assetsContentTableView.reloadData()
            }
        }
    }
    
    @IBAction func transactionsButton(_ sender: Any) {
    }
    
    
    
    func cellRegister() {
        assetsContentTableView.register(UINib(nibName: "GraphTableViewCell", bundle: nil), forCellReuseIdentifier: "GraphTableViewCell")
        assetsContentTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        assetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        assetsContentTableView.register(UINib(nibName: "BalanceCoinTableViewCell", bundle: nil), forCellReuseIdentifier: "BalanceCoinTableViewCell")
        assetsContentTableView.register(UINib(nibName: "LineTableViewCell", bundle: nil), forCellReuseIdentifier: "LineTableViewCell")
        assetsContentTableView.register(UINib(nibName: "RatioGraphTableViewCell", bundle: nil), forCellReuseIdentifier: "RatioGraphTableViewCell")
        assetsContentTableView.register(UINib(nibName: "RatioTableViewCell", bundle: nil), forCellReuseIdentifier: "RatioTableViewCell")
        assetsContentTableView.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
        assetsContentTableView.register(UINib(nibName: "WalletTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletTableViewCell")
        assetsContentTableView.register(UINib(nibName: "AddExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "AddExchangeTableViewCell")
        assetsContentTableView.register(UINib(nibName: "UsdInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UsdInfoTableViewCell")
    }
}

extension MyAssetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //MARK: - 그래프 그려지는 Cell
            return 1
        } else if section == 1 {
            //MARK: - 코인별 Title
            return 1
        } else if section == 2 {
            //MARK: - 코인별 리스트 컨트롤러
            return 1
        } else if section == 3 {
            //MARK: - Finished Coin
            return finishedCount
        } else if section == 4 {
            //MARK: - 구분선
            if airDropCount > 0 {
                return 1
            } else {
                return 0
            }
        } else if section == 5 {
            //MARK: - 에어드랍 리스트
            return airDropCount
        } else if section == 6 {
            //MARK: - 준비중 리스트
            return runningCount
        } else if section == 7 {
            //MARK: - 코인별 Title
            return 1
        } else if section == 8 {
            //MARK: - 코인 비중 그래프
            return 1
        } else if section == 9 {
            //MARK: - 코인 비중 리스트
            return totalCoinCount
        } else if section == 10 {
            //MARK: - 거래소 Title
            return 1
        } else if section == 11 {
            //MARK: - 거래소 리스트
            return exchangesCount
        } else if section == 12 {
            //MARK: - 구분선
            return 1
        } else if section == 13 {
            //MARK: - 지갑
            return 1
        } else if section == 14 {
            //MARK: - 추가 연결 버튼
            return 1
        } else if section == 15 {
            //MARK: - 원 달러 환율
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: - 그래프 그려지는 Cell
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as! GraphTableViewCell
            
            let totalAssetString = String(totalAsset)
            let revenueAmountString = String(revenueAmount)
            
            cell.totalAssetLabel.text = totalAssetString.insertComma + "원"
            if revenueAmount < 0 {
                cell.revenueAmountLabel.textColor = UIColor(red: 0.2824, green: 0.502, blue: 0.9333, alpha: 1.0)
            } else {
                cell.revenueAmountLabel.textColor = UIColor(red: 0.8667, green: 0.3216, blue: 0.3412, alpha: 1.0)
            }
            
            cell.revenueAmountLabel.text = revenueAmountString.insertComma + "원(\(yield * 100)%)"
            
            cell.startEndLabel.text = collectionStartEnd
            cell.avgBuyPriceLabel.text = String(avgBuyPrice).insertComma + "원"
            
            return cell
        } else if indexPath.section == 1 {
            //MARK: - 코인별 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "총 \(totalCoinCount)개의 자산을\n가지고 있어요"
            return cell
        } else if indexPath.section == 2 {
            //MARK: - 코인별 리스트 컨트롤러
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            cell.cellHeightConstraint.constant = 60
            return cell
        } else if indexPath.section == 3 {
            //MARK: - Finished Coin
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = finishedCoins?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = finishedCoins?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = finishedCoins?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = finishedCoins?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = finishedCoins?[indexPath.row].valuationPrice else { return UITableViewCell() }
            guard let yield = finishedCoins?[indexPath.row].yield else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = "\(valuationPrice.insertComma)원"
            
            var doubleYield: Double = Double(yield) ?? 0
            if doubleYield >= 0 {
                cell.yieldLabel.textColor = UIColor(red: 0.8667, green: 0.3216, blue: 0.3412, alpha: 1.0)
            } else {
                doubleYield = (doubleYield * -1)
                cell.yieldLabel.textColor = UIColor(red: 0.2824, green: 0.502, blue: 0.9333, alpha: 1.0)
            }
            cell.yieldLabel.text = "\(doubleYield * 100)%"
            return cell
        } else if indexPath.section == 4 {
            //MARK: - 구분선
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "LineTableViewCell", for: indexPath) as! LineTableViewCell
            return cell
        } else if indexPath.section == 5 {
            //MARK: - AirDrop Coin
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = airDropCoins?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = airDropCoins?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = airDropCoins?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = airDropCoins?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = airDropCoins?[indexPath.row].valuationPrice else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = valuationPrice
            cell.yieldLabel.textColor = UIColor(red: 0.6941, green: 0.7216, blue: 0.7529, alpha: 1.0)
            cell.yieldLabel.text = "에어드랍"
            return cell
        } else if indexPath.section == 6 {
            //MARK: - Running Coin
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
            guard let thumbnail = runningCoins?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let coinName = runningCoins?[indexPath.row].name else { return UITableViewCell() }
            guard let amount = runningCoins?[indexPath.row].amount else { return UITableViewCell() }
            guard let ticker = runningCoins?[indexPath.row].ticker else { return UITableViewCell() }
            guard let valuationPrice = runningCoins?[indexPath.row].valuationPrice else { return UITableViewCell() }
            
            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            cell.coinNameLabel.text = coinName.ko ?? coinName.en
            cell.amountLabel.text = "\(amount) \(ticker)"
            cell.valuationPriceLabel.text = valuationPrice
            cell.yieldLabel.textColor = UIColor(red: 0.6941, green: 0.7216, blue: 0.7529, alpha: 1.0)
            cell.yieldLabel.text = "수집중..."
            return cell
        } else if indexPath.section == 7 {
            //MARK: - 코인별 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            // index error 키 에러
            guard let coin = coinRatio.first?.key else { return UITableViewCell() }
                    
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "\(coin)에\n관심이 많으시네요"
            return cell
        } else if indexPath.section == 8 {
            //MARK: - 코인 비중 그래프
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "RatioGraphTableViewCell", for: indexPath) as! RatioGraphTableViewCell
            return cell
        } else if indexPath.section == 9 {
            //MARK: - 코인 비중 리스트
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "RatioTableViewCell", for: indexPath) as! RatioTableViewCell
            let coinName = coinRatio[indexPath.row].key
            let coinRatio = coinRatio[indexPath.row].value
            cell.coinColorView.layer.cornerRadius = cell.coinColorView.layer.frame.width / 2
            cell.coinColorView.clipsToBounds = true
            cell.coinNameLabel.text = coinName
            cell.coinRatioLabel.text = "\(coinRatio * 100)%"
            return cell
        } else if indexPath.section == 10 {
            //MARK: - 거래소 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 92
            cell.titleLabel.text = "내 거래소"
            return cell
        } else if indexPath.section == 11 {
            //MARK: - 거래소 리스트
            print("여기서 에러?")
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
            print("아니면 여기")
            guard let thumbnail = exchanges?[indexPath.row].thumbnail else { return UITableViewCell() }
            guard let exchangeName = exchanges?[indexPath.row].name else { return UITableViewCell() }
            guard let valuationPrice = exchanges?[indexPath.row].valuationPrice else { return UITableViewCell() }
            guard let yield = exchanges?[indexPath.row].yield else { return UITableViewCell() }
            guard let coinCount = exchanges?[indexPath.row].coinCount else { return UITableViewCell() }

            let url = URL(string: thumbnail)
            guard let data = try? Data(contentsOf: url!) else { return UITableViewCell() }
            
            cell.thumbnailImageView.image = UIImage(data: data)
            let name = exchangeName.ko ?? exchangeName.en ?? "error"
            cell.exchangeNameLabel.text = "\(String(describing: name))·자산 \(coinCount)개"
            cell.valuationPriceLabel.text = "\(valuationPrice.insertComma)원"
            var printYield: Double = Double(yield) ?? 0
            if printYield >= 0 {
                cell.yieldLabel.textColor = UIColor(red: 0.8667, green: 0.3216, blue: 0.3412, alpha: 1.0)
            } else {
                printYield = (printYield * -1)
                cell.yieldLabel.textColor = UIColor(red: 0.2824, green: 0.502, blue: 0.9333, alpha: 1.0)
            }
            cell.yieldLabel.text = "\(printYield * 100)%"
            return cell
        } else if indexPath.section == 12 {
            //MARK: - 구분선
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "LineTableViewCell", for: indexPath) as! LineTableViewCell
            return cell
        } else if indexPath.section == 13 {
            //MARK: - 지갑
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
            return cell
        } else if indexPath.section == 14 {
            //MARK: - 추가 연결 버튼
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "AddExchangeTableViewCell", for: indexPath) as! AddExchangeTableViewCell
            cell.addExchangeButton.addTarget(self, action: #selector(addExchange), for: .touchUpInside)
            return cell
        }  else if indexPath.section == 15 {
            //MARK: - 원 달러 환율
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "UsdInfoTableViewCell", for: indexPath) as! UsdInfoTableViewCell
            
            guard let price = usdInfo?.price else { return UITableViewCell() }
            guard let updateTime = usdInfo?.updateTime else { return UITableViewCell() }
            guard let valueOfChange = usdInfo?.valueOfChange else { return UITableViewCell () }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:m:s" // 2020-08-13 16:30
                    
            let convertDate = dateFormatter.date(from: updateTime) // Date 타입으로 변환
                    
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "M월 d일 a h시 m분 기준" // 2020년 08월 13일 오후 04시 30분
            myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)
            let convertTime = myDateFormatter.string(from: convertDate!)


            cell.priceLabel.text = "\(price.insertComma)원"
            cell.updateTimeLabel.text = convertTime
            cell.valueOfChangeLabel.text = valueOfChange
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func addExchange() {
        guard let addExchangeVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeConnectionViewController") as? ExchangeConnectionViewController else { return }
        
        addExchangeViewModel.getCoinBalanceData { [weak self] in
            guard let exchanges = self?.addExchangeViewModel.exchangeList else { return }
            
            var localList: [Keys] = []
            var foreignList: [Keys] = []
            var othersList: [Keys] = []
            var isRegisteredList: [[Bool]] = [[],[],[]]
            for exchange in exchanges {
                guard let type = exchange.type else { return }
                if type == "L" {
                    localList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[0].append(isRegistered ?? false)
                } else if type == "F" {
                    foreignList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[1].append(isRegistered ?? false)
                } else {
                    othersList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[2].append(isRegistered ?? false)
                }
            }
            
            addExchangeVC.isRegisteredList = isRegisteredList
            addExchangeVC.localList = localList
            addExchangeVC.foreignList = foreignList
            addExchangeVC.othersList = othersList
            
            self?.navigationController?.pushViewController(addExchangeVC, animated: true)
        }
    }
}

extension MyAssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            guard let coinDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CoinDetailsViewController") as? CoinDetailsViewController else { return }
            guard let finishedCoins = finishedCoins else { return }
            coinDetailsVC.selectedCoin = finishedCoins[indexPath.row]
            
            var symbolList: [[String]] = []
            
            for coin in finishedCoins {
                if let ticker = coin.ticker {
                    symbolList.append([ticker, coin.name?.ko ?? coin.name?.en ?? "error"])
                }
            }
            coinDetailsVC.symbolList = symbolList
            self.navigationController?.pushViewController(coinDetailsVC, animated: true)
        } else if indexPath.section == 11 {
            guard let exchangeDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeDetailsViewController") as? ExchangeDetailsViewController else { return }
            guard let exchange = exchanges else { return }
            exchangeDetailsVC.exchange = exchange[indexPath.row]
            self.navigationController?.pushViewController(exchangeDetailsVC, animated: true)
        }
    }
    
}


extension String { /** 숫자형 문자열에 3자리수 마다 콤마 넣기 Double형으로 형변환 되지 않으면 원본을 유지한다. ```swift let
                    stringValue = "10005000.123456789" print(stringValue.insertComma) // 결과 : "10,005,000.123456789" ``` */
    var insertComma: String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .decimal // 소수점이 있는 경우 처리
        if let _ = self.range(of: ".") {
            let numberArray = self.components(separatedBy: ".")
            if numberArray.count == 1 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString) else { return self }
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            } else if numberArray.count == 2 {
                var numberString = numberArray[0]
                if numberString.isEmpty { numberString = "0" }
                guard let doubleValue = Double(numberString) else { return self }
                return (numberFormatter.string(from: NSNumber(value: doubleValue)) ?? numberString) + ".\(numberArray[1])" }
        } else { guard let doubleValue = Double(self) else { return self }
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
        }
        return self
    }
}

