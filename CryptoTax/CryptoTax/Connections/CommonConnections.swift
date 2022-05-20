//
//  CommonConnections.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation
import Alamofire

//aes-256-cbc

class CommonConnections {
    
    private let MAIN_URL = "http://3.34.156.50:3000/api"
//    func faqAPI() {
//        print("더보기/고객센터/자주묻는질문")
//    }
//
//    func initAPI(initCompletionHandler: @escaping (Result<InitResponse, Error>) -> Void) {
//        print("서버 정보")
//        let url = MAIN_URL + "init"
//
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
////        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        request.timeoutInterval = 10
//
//        AF.request(request)
//            .responseData(completionHandler: { (response) in
//                switch response.result {
//                case .success(let value):
//
////                    print(value.base64EncodedData(options: .endLineWithCarriageReturn))
//                    print(value.count)
//
////                    let encryptData = AES256Util.encrypt(string: data.base64EncodedString())
////
////                    print(encryptData)
//
//
////                    print(data.base64EncodedString())
//                    print("====")
//                    do {
//                        let decoder = JSONDecoder()
//                        let result = try decoder.decode(InitResponse.self, from: value)
//                        initCompletionHandler(.success(result))
//                    } catch {
//                        initCompletionHandler(.failure(error))
//                    }
//                case let .failure(error):
//                    initCompletionHandler(.failure(error))
//                }
//            })
//    }
    
}
