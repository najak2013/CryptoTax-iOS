
//
//  ExchangeSelectData.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation

// 안드로이드와 iOS 받는 양식 정의하기
class ExchangeTestData {
    static let shared = ExchangeTestData()
    
    var exchangeList: Array<[String]> = [["Upbit", "Bithumb", "Coinone", "Korbit"], ["Binance", "Coinbase"], ["MetaMask"]]
    var exchangeSelected: Array<[String]> = [[], [], []]
    var exchangeState: Array<[Bool]> = [[false, false, true, false], [false, false], [false]]
    
    private init() {}
}

class FirstStart {
    static let shared = FirstStart()
    var isFirst: Bool = true
}
