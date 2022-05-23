//
//  TransactionsModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import Foundation


internal struct TransactionsResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: TransactionsMore
}

internal struct TransactionsMore: Codable {
    internal let hasNextData: Bool
    internal let isCalcTaxDone: Bool
    internal let transactions: [Transactions]
}

internal struct Transactions: Codable {
    internal let buyPrice: String?
    internal let side: String?
    internal let amount: String?
    internal let fees: String?
    internal let orderCurrency: String?
    internal let finalAmount: String?
    internal let doneAtKst: String?
    internal let exchange: String?
    internal let exchangeName: ExchangeName?
    internal let detail: String?
    internal let paymentCurrency: String?
    internal let sideString: String?
    internal let paymentName: PaymentName?
    internal let orderName: OrderName?
}

internal struct PaymentName: Codable {
    internal let ko: String?
    internal let en: String?
}

internal struct OrderName: Codable {
    internal let ko: String?
    internal let en: String?
}
