//
//  UserJoinModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/19.
//

import Foundation


internal struct ExchangeJoinResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: ExchangeJoinMore?
}

internal struct ExchangeJoinMore: Codable {
    internal let jobIds : [JobIds]?
}

internal struct JobIds: Codable {
    internal let job: String?
    internal let id: String?
}
