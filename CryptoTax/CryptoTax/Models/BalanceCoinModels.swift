//
//  CoinBalance.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/19.
//

import Foundation


internal struct BalanceCoinResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: BalanceCoinMore
}

internal struct BalanceCoinMore: Codable {
    internal let balance : BalanceCoin
}

internal struct BalanceCoin: Codable {
    internal let exchange: [Coin]
}

internal struct Coin: Codable {
    internal let ticker: String
    internal let thumbnail: String
    internal let name: CoinName
    internal let amount: Double
    internal let buyPriceExists: Bool
    internal let yield: Double?
}

internal struct CoinName: Codable {
    internal let ko: String
    internal let en: String
}
