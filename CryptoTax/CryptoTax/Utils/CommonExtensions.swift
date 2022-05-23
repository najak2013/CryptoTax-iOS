//
//  CommonExtensions.swift
//  CryptoTax
//
//  Created by 김지태 on 2022/05/23.
//

import Foundation
import UIKit


extension UILabel {
    func asColor(target: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: target)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
