//
//  Utils.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/11.
//

import Foundation


public class Storage {
    static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
}
