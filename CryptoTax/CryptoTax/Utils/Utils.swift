//
//  Utils.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/11.
//

import Foundation
import UIKit

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



//MARK: - Textfield Under Lune Controller
class TextFieldUnderLineController {
    // 평소 색상
    func defaultUnderLine(underLine: UIView) {
        underLine.backgroundColor = UIColor(red: 0.949, green: 0.9569, blue: 0.9647, alpha: 1.0)
    }
    
    // 선택 색상
    func activeUnderLine(underLine: UIView) {
        underLine.backgroundColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0)
    }
    
    
    // 에러 색상
    func errorUnderLine(underLine: UIView) {
        underLine.backgroundColor = UIColor(red: 0.9686, green: 0, blue: 0.0157, alpha: 1.0)
    }
}


//MARK: - Textfield Float Label Controller
class TextFieldFloatLabelController {
    // Float 전용 Label 만들기
    func createFloatLabel(textfield: UITextField) -> UILabel {
        let floatLabel = UILabel()
        floatLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y, width: textfield.frame.width, height: 18)
        floatLabel.font = floatLabel.font.withSize(14)
        floatLabel.text = textfield.placeholder
        floatLabel.textColor = UIColor(red: 0.5529, green: 0.5804, blue: 0.6275, alpha: 1.0)
        return floatLabel
    }
    
    // 평소 Float
    func defaultFloatLabel(textfield: UITextField, uiLabel: UILabel, placeholder: String) {
        uiLabel.font = uiLabel.font.withSize(textfield.font!.pointSize)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            uiLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y + uiLabel.frame.height + 7, width: textfield.frame.width, height: 18)
        }, completion: nil)
        
        textfield.placeholder = placeholder
        uiLabel.removeFromSuperview()
        
    }
    
    // 활성화 Float
    func activeFloatLabel(textfield: UITextField, userInputView: UIView, uiLabel: UILabel) {
        userInputView.addSubview(uiLabel)
        textfield.placeholder = ""
        uiLabel.font = uiLabel.font.withSize(textfield.font!.pointSize - 9)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            uiLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y - uiLabel.frame.height - 7, width: textfield.frame.width, height: 18)
        }, completion: nil)
        
    }
}
