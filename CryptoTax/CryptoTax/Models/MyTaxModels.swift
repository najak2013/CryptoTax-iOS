//
//  MyTaxModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/22.
//

import Foundation

internal struct MyTaxResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: MyTaxMore?
}

internal struct MyTaxMore: Codable {
    internal let taxRemainingDays : String?
    internal let expectedTax : ExpectedTax?
    internal let isCalcTaxDone : Bool?
    internal let taxBasis : TaxBasis?
}


internal struct TaxBasis: Codable {
    internal let exchangeCount: Int?
    internal let transactionCount: Int?
    internal let currencyCount: Int?
}

internal struct ExpectedTax: Codable {
    internal let otherCost: String?
    internal let expectedTax: String?
    internal let incomeTax: String?
    internal let totalRevenueAmount: String?
    internal let basicDeduction: String?
    internal let exchangeFee: String?
    internal let localTax: String?
    internal let taxBaseAmount: String?
    internal let purchaseAmount: String?
}

