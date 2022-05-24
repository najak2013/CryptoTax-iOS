//
//  MyAssetsViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation


class CoinDetailsViewModel {
    
    var transactions: [Transactions]?
    
    func getTransactionsData(symbol: String, GetFinishedHandler: @escaping () -> ()) {
        getTransactions(exchanges: "", symbol: symbol, start_date: "", sort_order: "", skip: "", limit: "", GetTransactionsHandler: { result in
            switch result {
            case let .success(result):
                print(result)
                self.transactions = result.more.transactions
                GetFinishedHandler()
            case let .failure(error):
                print(error.localizedDescription)
                GetFinishedHandler()
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
