//
//  UserConnections.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation
import Alamofire

class BalanceConnections {
    private let MAIN_URL = "http://3.34.156.50:3000/api"
    
    func graph(section: String, to_date: String, duration: String, exchanges: String, symbol: String, price_type: String, session: String, GraphHandler: @escaping (Result<BalanceGraphResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/balance/graph"
        print("세션 : ", session)
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: BalanceGraphResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        GraphHandler(.success(response))
                    case let .failure(error):
                        GraphHandler(.failure(error))
                    }
                }
        
        
    }
    
    
    func exchange(exchanges: String, symbol:String, session: String, ExchangeBalanceHandler: @escaping (Result<BalanceExchangeResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/balance/exchange"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: BalanceExchangeResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        ExchangeBalanceHandler(.success(response))
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
    }
    
    func coin(exchanges: String, session: String, CoinBalanceHandler: @escaping (Result<BalanceCoinResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/balance/coin"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: BalanceCoinResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        CoinBalanceHandler(.success(response))
                    case let .failure(error):
                        CoinBalanceHandler(.failure(error))
                    }
                }
    }
}
