//
//  AddExchangeViewModel.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/25.
//

import Foundation





class AddExchangeViewModel {
    
    var exchangeList: [Keys]?
    
    func getCoinBalanceData(GetFinishedHandler: @escaping () -> ()) {
        getExchangeList(getExchangeHandler: { result in
            switch result {
            case let .success(result):
                guard let exchanges = result.more?.keys else { return }
                self.exchangeList = exchanges
                GetFinishedHandler()
            case let .failure(error):
                print(error)
                GetFinishedHandler()
            }
        })
    }
    
    func getExchangeList(getExchangeHandler: @escaping (Result<GetExchangeResponseModel, Error>) -> Void) {
        // n1hwShMDXUrY1jLitXf/0g==
        // UserInfo().getUserSession()x
        ExchangeConnections().getExchangeList(session: UserInfo().getUserSession(), getExchangeListBalanceHandler: { result in
            switch result {
            case let .success(result):
                getExchangeHandler(.success(result))
            case let .failure(error):
                getExchangeHandler(.failure(error))
            }
        })
    }
}
