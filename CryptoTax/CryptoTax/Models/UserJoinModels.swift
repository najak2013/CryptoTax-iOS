//
//  UserJoinModels.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/19.
//

import Foundation


internal struct UserResponseModel: Codable {
    internal let reason: String
    internal let code: String
    internal let more: UserJoinMore?
}


// 회원 정보
internal struct UserJoinMore: Codable {
    internal let session: String?
    internal let user: User?
    internal let msg: Msg?
}

internal struct Msg: Codable {
    internal let welcome: String?
}

internal struct User: Codable {
    internal let seq: Double?
    internal let name: UserName?
    internal let phone: String?
    internal let carrier: String?
    internal let home: Home?
    internal let company: Company?
    internal let overseasTaxFlag: Bool?
}

internal struct Company: Codable {
    internal let name: String?
    internal let zipcode: String?
    internal let address: String?
    internal let tel: String?
}

internal struct Home: Codable {
    internal let zipcode: String?
    internal let address: String?
    internal let tel: String?
}

internal struct UserName: Codable {
    internal let ko: String?
    internal let en: UserNameEN?
}

internal struct UserNameEN: Codable {
    internal let family: String?
    internal let given: String?
}
