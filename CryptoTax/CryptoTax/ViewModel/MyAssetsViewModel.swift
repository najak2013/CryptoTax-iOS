//
//  MyAssetsViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation


class MyAssetsViewModel {
    
    var coinCount: Int = 0
    
    func getCoinCount(CoinCountHandler: @escaping () -> ()) {
        getCoinBalance(exchanges: "", GetCoinHandler: { result in
                switch result {
                case let .success(result):
                    guard let airDrop = result.more.coin.airDrop else { return }
                    guard let running = result.more.coin.running else { return }
                    guard let finished = result.more.coin.finished else { return }
                    self.coinCount = airDrop.count + running.count + finished.count
                    print("끝")
                    CoinCountHandler()
                case let .failure(error):
                    print(error)
                }
            })
    }
    
    
    func getCoinBalance(exchanges: String, GetCoinHandler: @escaping (Result<BalanceCoinResponseModel, Error>) -> Void) {
        BalanceConnections().coin(exchanges: exchanges, session: UserInfo().getUserSession(), CoinBalanceHandler: { result in
            switch result {
            case let .success(result):
                GetCoinHandler(.success(result))
            case let .failure(error):
                GetCoinHandler(.failure(error))
            }
        })
    }
}
