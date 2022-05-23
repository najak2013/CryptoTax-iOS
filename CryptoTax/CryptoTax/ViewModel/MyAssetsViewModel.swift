//
//  MyAssetsViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation


class MyAssetsViewModel {
    
    var airDropCount: Int = 0
    var runningCount: Int = 0
    var finishedCount: Int = 0
    var totalCoinCount: Int = 0
    
    var airDropCoin: [CoinInfo]?
    var runningCoin: [CoinInfo]?
    var finishedCoin: [CoinInfo]?
    
    var coinRatio: [Dictionary<String, Double>.Element]?
    
    var exchanges: [Exchange]?
    var exchangesCount: Int = 0
    var usdInfo: UsdInfo?
    
//    func getCoinCount(CoinCountHandler: @escaping () -> ()) {
//        getCoinBalance(exchanges: "", GetCoinHandler: { result in
//                switch result {
//                case let .success(result):
//                    guard let airDrop = result.more.coin.airDrop else { return }
//                    guard let running = result.more.coin.running else { return }
//                    guard let finished = result.more.coin.finished else { return }
//
//                    self.airDropCount = airDrop.count
//                    self.runningCount = running.count
//                    self.finishedCount = finished.count
//
//                    self.totalCoinCount = airDrop.count + running.count + finished.count
//
//
//
//
//                    CoinCountHandler()
//                case let .failure(error):
//                    print(error)
//                }
//            })
//    }
    
    func getCoinBalanceData(GetFinishedHandler: @escaping () -> ()) {
        getCoinBalance(exchanges: "", GetCoinHandler: { result in
            switch result {
            case let .success(result):
                guard let airDrop = result.more.coin.airDrop else { return }
                guard let running = result.more.coin.running else { return }
                guard let finished = result.more.coin.finished else { return }
                
                self.airDropCount = airDrop.count
                self.runningCount = running.count
                self.finishedCount = finished.count
                self.totalCoinCount = airDrop.count + running.count + finished.count
                
                self.airDropCoin = airDrop
                self.runningCoin = running
                self.finishedCoin = finished
                
                self.getHighestRatioCoin(airDrop: airDrop, running: running, finished: finished)
                
                GetFinishedHandler()
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func getExchangeBalanceData(GetFinishedHandler: @escaping () -> ()) {
        getExchangeBalance(exchanges: "", symbol: "", GetExchangeHandler: { result in
            switch result {
            case let .success(result):
                guard let exchanges = result.more.exchange else { return }
                guard let usdInfo = result.more.usdInfo else { return }
                
                self.exchanges = exchanges
                self.exchangesCount = exchanges.count
                self.usdInfo = usdInfo
                
                GetFinishedHandler()
            case let .failure(error):
                print(error)
            }
        })
    }
    
    
    func getHighestRatioCoin(airDrop: [CoinInfo], running: [CoinInfo], finished: [CoinInfo]) {
        
        var ratioList = [String: Double]()
        
        for coin in airDrop {
            guard let coinRatio = Double(coin.ratio ?? "0.00") else { return }
            
            ratioList[(coin.name?.ko ?? coin.name?.en) ?? "error"] = coinRatio
        }
        for coin in running {
            guard let coinRatio = Double(coin.ratio ?? "0.00") else { return }
            
            ratioList[(coin.name?.ko ?? coin.name?.en) ?? "error"] = coinRatio
        }
        for coin in finished {
            guard let coinRatio = Double(coin.ratio ?? "0.00") else { return }
            
            ratioList[(coin.name?.ko ?? coin.name?.en) ?? "error"] = coinRatio
        }
        coinRatio = ratioList.sorted { $0.1 > $1.1 }
        
//        for i in 0..<sortedDitionary.count {
//            print("\(i+1).\(sortedDitionary[i].key)")
//        }
    }
    
    func getCoinBalance(exchanges: String, GetCoinHandler: @escaping (Result<BalanceCoinResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()
        BalanceConnections().coin(exchanges: exchanges, session: UserInfo().getUserSession(), CoinBalanceHandler: { result in
            switch result {
            case let .success(result):
                GetCoinHandler(.success(result))
            case let .failure(error):
                GetCoinHandler(.failure(error))
            }
        })
    }
    
    
    func getExchangeBalance(exchanges: String, symbol: String, GetExchangeHandler: @escaping (Result<BalanceExchangeResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()x
        BalanceConnections().exchange(exchanges: exchanges, symbol: symbol, session: UserInfo().getUserSession(), ExchangeBalanceHandler: { result in
            switch result {
            case let .success(result):
                GetExchangeHandler(.success(result))
            case let .failure(error):
                GetExchangeHandler(.failure(error))
            }
        })
    }
}