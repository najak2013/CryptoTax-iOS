//
//  TransactionsConnections.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import Foundation
import Alamofire


class TransactionsConnections {
    private let MAIN_URL = "http://3.34.156.50:3000/api"
    
    func transactions(exchanges: String, symbol: String, start_date:String, sort_order:String, skip:String, limit:String, session: String, TransactionsHandler: @escaping (Result<TransactionsResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/coin/transactions"
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: TransactionsResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        TransactionsHandler(.success(response))
                    case let .failure(error):
                        TransactionsHandler(.failure(error))
                    }
                }
    }
}
