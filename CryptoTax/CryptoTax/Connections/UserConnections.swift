//
//  UserConnections.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation
import Alamofire

class UserConnection {
    private let MAIN_URL = "http://3.34.156.50:3000/api"
    
    func userJoin(authInfo: String, user: String, userJoinHandler: @escaping (Result<UserResponseModel, Error>) -> Void) {
        let url = MAIN_URL + "/user/join"
        
        let parameters: Parameters = [
                "authInfo": authInfo,
                "user" : user,
                "pushToken" : "푸시토큰",
                "appVersion" : "0.0.1"
                ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json; charset=utf-8", "Accept":"application/json"])
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["application/json"])
                    .responseDecodable(of: UserResponseModel.self) { (response) in
                    switch response.result {
                    case .success(let response):
                        print(response)
                        userJoinHandler(.success(response))
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
    }
}
