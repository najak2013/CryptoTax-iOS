
//
//  ExchangeSelectData.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation


class ExchangeTestData {
    static let shared = ExchangeTestData()
    
    var exchangeList: Array<[String]> = [["업비트", "빗썸", "코인원"], ["미국", "러시아", "일본", "프랑스", "영국", "독일"], ["아반떼", "소나타", "롤스로이스", "트럭"]]
    var exchangeSelected: Array<[String]> = [[], [], []]
    var exchangeState: Array<[Bool]> = [[true, false, true], [false, true, false, false, false, false], [false, false, false, false]]
    
    private init() {}
}
