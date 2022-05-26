//
//  AllProtocol.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/11.
//

import Foundation
import UIKit

protocol SelectCarrierProtocol {
    func getCarrier(_ vc: UIViewController, carrier: String)
}


protocol NextViewProtocol {
    func nextView(_ vc: UIViewController)
}

protocol AddExchangeToServer {
    func exchange(_ vc: UIViewController, section: Int, row: Int)
}

