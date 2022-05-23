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
    
    var airDropCount: Int = 0
    var runningCount: Int = 0
    var finishedCount: Int = 0
    
    var totalCoinCount: Int = 0
    
    var finishedCoin: [CoinInfo]?
    var airDropCoin: [CoinInfo]?
    var runningCoin: [CoinInfo]?
    
    var coinRatio: [Dictionary<String, Double>.Element] = []
    
    var exchanges: [Exchange]?
    var exchangesCount: Int = 0
    var usdInfo: UsdInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assetsContentTableView.rowHeight = UITableView.automaticDimension
        assetsContentTableView.dataSource = self
        assetsContentTableView.delegate = self
        cellRegister()
        
        myAssetsViewModel.getCoinBalanceData { [weak self] in
            self?.airDropCount = self?.myAssetsViewModel.airDropCount ?? 0
            self?.runningCount = self?.myAssetsViewModel.runningCount ?? 0
            self?.finishedCount = self?.myAssetsViewModel.finishedCount ?? 0
            
            self?.totalCoinCount = self?.myAssetsViewModel.totalCoinCount ?? 0
            
            self?.finishedCoin = self?.myAssetsViewModel.finishedCoin
            self?.airDropCoin = self?.myAssetsViewModel.airDropCoin
            self?.runningCoin = self?.myAssetsViewModel.runningCoin
            
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
        assetsContentTableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
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
        return 19
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
        } else if section == 10 {
            //MARK: - 코인 비중 그래프
            return 1
        } else if section == 11 {
            //MARK: - 코인 비중 리스트
            return totalCoinCount
        } else if section == 12 {
            //MARK: - 거래소 Title
            return 1
        } else if section == 13 {
            //MARK: - 거래소 리스트
            return exchangesCount
        } else if section == 14 {
            //MARK: - 구분선
            return 1
        } else if section == 15 {
            //MARK: - 지갑
            return 1
        } else if section == 16 {
            //MARK: - 추가 연결 버튼
            return 1
        } else if section == 17 {
            //MARK: - Cell 사이 간격
            return 1
        } else if section == 18 {
            //MARK: - 원 달러 환율
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: - 그래프 그려지는 Cell
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as! GraphTableViewCell
            return cell
        } else if indexPath.section == 1 {
            //MARK: - Cell 사이 간격
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 2 {
            //MARK: - 코인별 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "총 \(totalCoinCount)개의 자산을\n가지고 있어요"
            return cell
        } else if indexPath.section == 3 {
            //MARK: - 코인별 리스트 컨트롤러
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            return cell
        } else if indexPath.section == 4 {
            //MARK: - Finished Coin
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
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
        } else if indexPath.section == 5 {
            //MARK: - 구분선
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "LineTableViewCell", for: indexPath) as! LineTableViewCell
            return cell
        } else if indexPath.section == 6 {
            //MARK: - AirDrop Coin
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
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
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "BalanceCoinTableViewCell", for: indexPath) as! BalanceCoinTableViewCell
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
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 9 {
            //MARK: - 코인별 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            // index error 키 에러
            guard let coin = coinRatio.first?.key else { return UITableViewCell() }
                    
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "\(coin)에\n관심이 많으시네요"
            return cell
        } else if indexPath.section == 10 {
            //MARK: - 코인 비중 그래프
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "RatioGraphTableViewCell", for: indexPath) as! RatioGraphTableViewCell
            return cell
        } else if indexPath.section == 11 {
            //MARK: - 코인 비중 리스트
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "RatioTableViewCell", for: indexPath) as! RatioTableViewCell
            let coinName = coinRatio[indexPath.row].key
            let coinRatio = coinRatio[indexPath.row].value
            cell.coinColorView.layer.cornerRadius = cell.coinColorView.layer.frame.width / 2
            cell.coinColorView.clipsToBounds = true
            cell.coinNameLabel.text = coinName
            cell.coinRatioLabel.text = "\(coinRatio * 100)%"
            return cell
        } else if indexPath.section == 12 {
            //MARK: - 거래소 Title
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 92
            cell.titleLabel.text = "내 거래소"
            return cell
        } else if indexPath.section == 13 {
            //MARK: - 거래소 리스트
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
            
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
        } else if indexPath.section == 14 {
            //MARK: - 구분선
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "LineTableViewCell", for: indexPath) as! LineTableViewCell
            return cell
        } else if indexPath.section == 15 {
            //MARK: - 지갑
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
            return cell
        } else if indexPath.section == 16 {
            //MARK: - 추가 연결 버튼
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "AddExchangeTableViewCell", for: indexPath) as! AddExchangeTableViewCell
            return cell
        } else if indexPath.section == 17 {
            //MARK: - Cell 사이 간격
            let cell = assetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 18 {
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
}

extension MyAssetsViewController: UITableViewDelegate {
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

