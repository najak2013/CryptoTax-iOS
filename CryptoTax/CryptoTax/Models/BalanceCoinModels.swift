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
    internal let isCalcTaxDone: Bool
    internal let coin: Coin
    
}

internal struct Coin: Codable {
    internal let running: [CoinInfo]?
    internal let airDrop: [CoinInfo]?
    internal let finished: [CoinInfo]?
}


internal struct CoinInfo: Codable {
    internal let ticker: String?
    internal let thumbnail: String?
    internal let amount: String?
    internal let valuationPrice: String?
    internal let yield: String?
    internal let name: CoinName?
    internal let purchasePrice: String?
    internal let buyPriceExists: Bool?
    internal let ratio: String?
}

internal struct CoinName: Codable {
    internal let ko: String?
    internal let en: String?
}
