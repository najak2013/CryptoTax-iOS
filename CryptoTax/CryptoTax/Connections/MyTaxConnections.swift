//
//  MyTaxConnections.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/19.
//

import Foundation
import Alamofire

class MyTaxConnections {
    private let MAIN_URL = "http://3.34.156.50:3000/api"
    
    func taxInfo(basic_year: String, session: String, MyTaxHandler: @escaping (Result<MyTaxResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/tax/expected"
        let parameters = ["basis_year": basic_year]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json", "session":session])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: MyTaxResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        MyTaxHandler(.success(response))
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
    }
}
