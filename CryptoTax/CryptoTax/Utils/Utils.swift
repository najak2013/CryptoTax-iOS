//
//  Utils.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/11.
//

import Foundation
import UIKit
import Locksmith

//MARK: - 앱 처음 시작 확인
public class AppFirstTime {
    // 유저 등록이 필요한 여부
    func userNeedToRegist() -> Bool {
        if AppFirstTime.isFirstTime() {
            print("어플리케이션 처음 실행입니다.")
            return true
        } else {
            if !AppFirstTime.userLogin() {
                return false
            }
            return true
        }
    }
    
    
    static func userLogin() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "userSession") == nil {
            return true
        } else {
            return false
        }
    }
    
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

internal class UserInfo {
    
    let defaults = UserDefaults.standard
    
    func getUserName() -> String {
        if let userName = defaults.object(forKey: "userName") {
            return userName as! String
        }
        return ""
    }

    func getUserSession() -> String {
        if let userSession = defaults.object(forKey: "userSession") {
            return userSession as! String
        }
        return ""
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
    func defaultFloatLabel(textfield: UITextField, uiLabel: UILabel, placeholder: String, fontSize: CGFloat) {
        uiLabel.font = uiLabel.font.withSize(textfield.font!.pointSize)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            uiLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y + uiLabel.frame.height + 7, width: textfield.frame.width, height: 18)
        }, completion: nil)
        
        textfield.placeholder = placeholder
        uiLabel.removeFromSuperview()
        
    }
    
    // 활성화 Float
    func activeFloatLabel(textfield: UITextField, userInputView: UIView, uiLabel: UILabel, fontSize: CGFloat) {
        userInputView.addSubview(uiLabel)
        textfield.placeholder = ""
        uiLabel.font = uiLabel.font.withSize(fontSize - 9)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            uiLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y - uiLabel.frame.height - 7, width: textfield.frame.width, height: 18)
        }, completion: nil)
        
    }
}

class ModalViewRadius {
    func viewRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

