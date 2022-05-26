//
//  BalanceGraphModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import Foundation

internal struct BalanceGraphResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: BalanceGraphMore
}

internal struct BalanceGraphMore: Codable {
    internal let summary: Summary?
    internal let isCalcTaxDone: Bool?
}

internal struct Summary: Codable {
    internal let totalAsset: Int?
    internal let collectionEnd: String?
    internal let yield: Double?
    internal let collectionStart: String?
    internal let revenueAmount: Int?
    internal let avgBuyPrice: Double?
}
