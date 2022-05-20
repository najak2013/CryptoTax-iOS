//
//  RegistExchangeConnections.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/19.
//

import Foundation
import Alamofire


class ExchangeConnections {
    
    private let MAIN_URL = "http://3.34.156.50:3000/api"
    
    func key(session: String, exchangeName: String, accessKey: String, secretKey: String, exchangeKeyJoinHandler: @escaping (Result<ExchangeJoinResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/exchange/key"
        
        let parameters: Parameters = [
                "exchange": exchangeName,
                "accessKey" : accessKey,
                "secretKey" : secretKey
                ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: ExchangeJoinResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        print(response)
                        exchangeKeyJoinHandler(.success(response))
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
    }
    
    func keys(session: String, exchangeName: String, accessKey: String, secretKey: String, exchangeKeyJoinHandler: @escaping (Result<ExchangeJoinResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/exchange/key"
        
        let parameters: Parameters = [
                "exchange": exchangeName,
                "accessKey" : accessKey,
                "secretKey" : secretKey
                ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: ExchangeJoinResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        print(response)
//                        exchangeKeyJoinHandler(.success(reponse))
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
    }
    
    func crawling() {
        print("crawling")
    }
}

