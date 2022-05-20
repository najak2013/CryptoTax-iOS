//
//  BalanceExchangeModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/20.
//

import Foundation

internal struct BalanceExchangeResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: BalanceExchange
}

internal struct BalanceExchange: Codable {
    internal let isCalcTaxDone: Bool
    internal let exchange: [Exchange]?
    internal let usdInfo: UsdInfo?
}

internal struct Exchange: Codable {
    internal let amount: String?
    internal let thumbnail: String?
    internal let valuationPrice: String?
    internal let yield: String?
    internal let name: ExchangeName?
    internal let purchasePrice: String?
    internal let buyPriceExists: Bool?
    internal let coinCount: Int?
    internal let ratio: String?
}

internal struct ExchangeName: Codable {
    internal let ko: String?
    internal let en: String?
}

internal struct UsdInfo: Codable {
    internal let price: String?
    internal let rateOfChange: String?
    internal let updateTime: String?
    internal let valueOfChange: String?
}
