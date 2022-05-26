//
//  GetExchangeModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/25.
//

import Foundation

internal struct GetExchangeResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: GetExchangeMore?
}


internal struct GetExchangeMore: Codable {
    internal let keys: [Keys]?
}



internal struct Keys: Codable {
    internal let name: ExchangeName?
    internal let type: String?
    internal let isRegistered: Bool?
    internal let logo: String?
}
