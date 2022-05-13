//
//  ResponseModel.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import Foundation


internal struct InitResponse: Codable {
    internal let reason: String
    internal let code: String
    internal let more: [InitMore]
}


internal struct InitMore: Codable {
    internal let appInfo: AppInfo
    internal let splach: Splash
}

internal struct AppInfo: Codable {
    internal let version: String
    internal let forceUpdateFlag: Bool
}


internal struct Splash: Codable {
    internal let path: String
    internal let version: String
}
