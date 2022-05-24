//
//  MyAssetsViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation


class CoinDetailsViewModel {
    // 초기화 필요
    var selectedCoin: CoinInfo?
    var transactions: [Transactions]?
    
    func getCoinBalanceData(symbol: String, GetFinishedHandler: @escaping () -> ()) {
        getCoinBalance(exchanges: "", symbol: symbol, GetCoinHandler: { result in
            switch result {
            case let .success(result):
                guard let finished = result.more.coin.finished else { return }
                self.selectedCoin = finished.first
                GetFinishedHandler()
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func getTransactionsData(symbol: String, GetFinishedHandler: @escaping () -> ()) {
        getTransactions(exchanges: "", symbol: symbol, start_date: "", sort_order: "", skip: "", limit: "", GetTransactionsHandler: { result in
            switch result {
            case let .success(result):
                self.transactions = result.more.transactions
                GetFinishedHandler()
            case let .failure(error):
                print(error.localizedDescription)
                GetFinishedHandler()
            }
        })
    }
    
    func getCoinBalance(exchanges: String, symbol: String, GetCoinHandler: @escaping (Result<BalanceCoinResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()
        BalanceConnections().coin(exchanges: exchanges, symbol: symbol, session: UserInfo().getUserSession(), CoinBalanceHandler: { result in
            switch result {
            case let .success(result):
                GetCoinHandler(.success(result))
            case let .failure(error):
                GetCoinHandler(.failure(error))
            }
        })
    }
    
    func getTransactions(exchanges: String, symbol: String, start_date: String, sort_order: String, skip: String, limit: String, GetTransactionsHandler: @escaping (Result<TransactionsResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()x
        TransactionsConnections().transactions(exchanges: exchanges, symbol: symbol, start_date: start_date, sort_order: sort_order, skip: skip, limit: limit, session: UserInfo().getUserSession(), TransactionsHandler: { result in
            switch result {
            case let .success(result):
                GetTransactionsHandler(.success(result))
            case let .failure(error):
                GetTransactionsHandler(.failure(error))
            }
        })
    }
}
