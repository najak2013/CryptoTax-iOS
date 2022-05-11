//
//  RegistNameViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/03.
//

import UIKit

class UserRegistViewController: BaseViewController, UITextFieldDelegate, SelectCarrierProtocol {
    
    
    @IBOutlet var textfields: [UITextField]!
    @IBOutlet var userInputViews: [UIView]!
    @IBOutlet var circleViews: [UIView]!
    
    @IBOutlet var underLines: [UIView]!
    
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 57))
    var uiLabels: [UILabel] = []
    var placeholders: [String] = []
    
    
    var count: Int = 0
    
    var userCarrier: String?
    
    @IBOutlet weak var bottomBuntton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAlphaInit()
        keyboardButtonInit()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textfieldInit()
        circleViewInit()
    }
    
    
    @IBAction func carrierButton(_ sender: Any) {
        guard let SelectCarrierModalVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCarrierModalViewController") as? SelectCarrierModalViewController else { return }
        SelectCarrierModalVC.modalPresentationStyle = .overFullScreen
        
        SelectCarrierModalVC.delegate = self
        
        present(SelectCarrierModalVC, animated: false, completion: nil)
    }
    
    func getCarrier(_ vc: UIViewController, carrier: String) {
        activeFloatLabel(textfieldIndex: 2, textfield: textfields[2])
        textfields[2].text = carrier
    }
    
    func keyboardButtonInit() {
        button.backgroundColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0)
        button.setTitle("확인", for: .normal)
    }
    
    func viewAlphaInit() {
        for view in userInputViews {
            let viewIndex = userInputViews.firstIndex(of: view)!
            if viewIndex != 0 {
                view.alpha = 0
            }
        }
    }
    
    func circleViewInit() {
        for view in circleViews {
            view.layer.cornerRadius = view.layer.frame.width / 2
            view.clipsToBounds = true
        }
    }
    

    
    func textfieldInit() {
        for textfield in textfields {
            print("델리게이트 생성")
            // textfield 델리게이트 설정
            textfield.delegate = self
            
            // textfield float을 위한 Label 생성
            createFloatLabel(textfield: textfield)
            
            placeholders.append(textfield.placeholder!)
        }
    }
    
    func createFloatLabel(textfield: UITextField) {
        let floatLabel = UILabel()
        floatLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y, width: textfield.frame.width, height: 18)
        floatLabel.font = floatLabel.font.withSize(14)
        floatLabel.text = textfield.placeholder
        floatLabel.textColor = UIColor(red: 0.5529, green: 0.5804, blue: 0.6275, alpha: 1.0)
        uiLabels.append(floatLabel)
    }
        
    
    
 
    @IBOutlet var constraints: [NSLayoutConstraint]!
    
    
    //휴대폰 번호
    //통신사
    //주민등록번호
    //이름
    @IBAction func nextButton(_ sender: Any) {
        if count != 3 {
            count += 1
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.userInputViews[self.count].alpha = 1
            }, completion: nil)
            for i in 0 ..< count{
                
                constraints[i].constant += 79
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        } else {
            guard let userAuthVC = self.storyboard?.instantiateViewController(withIdentifier: "UserAuthViewController") as? UserAuthViewController else { return }
            userAuthVC.modalPresentationStyle = .overFullScreen
            present(userAuthVC, animated: false, completion: nil)
        }
    }
    
    func defaultUnderLine(textfieldIndex: Int, textfield: UITextField) {
            print("defaultUnderLine")
            underLines[textfieldIndex].backgroundColor = UIColor(red: 0.949, green: 0.9569, blue: 0.9647, alpha: 1.0)
        }
    
    func activeUnderLine(textfieldIndex: Int, textfield: UITextField) {
        print("activeUnderLine")
        underLines[textfieldIndex].backgroundColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0)
    }
    
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        activeFloatLabel(textfieldIndex: textfieldIndex, textfield: textfield)
        activeUnderLine(textfieldIndex: textfieldIndex, textfield: textfield)
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        if textfield.text?.isEmpty ?? false {
            defaultFloatLabel(textfieldIndex: textfieldIndex, textfield: textfield)
        }
        defaultUnderLine(textfieldIndex: textfieldIndex, textfield: textfield)
    }
    
    func defaultFloatLabel(textfieldIndex: Int, textfield: UITextField) {
        if textfieldIndex != 4 {
            uiLabels[textfieldIndex].font = uiLabels[textfieldIndex].font.withSize(textfield.font!.pointSize)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.uiLabels[textfieldIndex].frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y + self.uiLabels[textfieldIndex].frame.height + 7, width: textfield.frame.width, height: 18)
            }, completion: nil)
            
            textfield.placeholder = placeholders[textfieldIndex]
            self.uiLabels[textfieldIndex].removeFromSuperview()
        }
    }
    func activeFloatLabel(textfieldIndex: Int, textfield: UITextField) {
        if textfieldIndex != 4 {
            userInputViews[textfieldIndex].addSubview(uiLabels[textfieldIndex])
            textfield.placeholder = ""
            uiLabels[textfieldIndex].font = uiLabels[textfieldIndex].font.withSize(textfield.font!.pointSize - 9)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.uiLabels[textfieldIndex].frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y - self.uiLabels[textfieldIndex].frame.height - 7, width: textfield.frame.width, height: 18)
            }, completion: nil)
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}






//
//extension UIViewController {
//
//    func setKeyboardObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//                  let keyboardRectangle = keyboardFrame.cgRectValue
//                  let keyboardHeight = keyboardRectangle.height
//              UIView.animate(withDuration: 1) {
//                  self.view.window?.frame.origin.y -= keyboardHeight
//              }
//          }
//      }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.window?.frame.origin.y != 0 {
//            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//                    let keyboardRectangle = keyboardFrame.cgRectValue
//                    let keyboardHeight = keyboardRectangle.height
//                UIView.animate(withDuration: 1) {
//                    self.view.window?.frame.origin.y += keyboardHeight
//                }
//            }
//        }
//    }
//}

protocol SelectCarrierProtocol {
    func getCarrier(_ vc: UIViewController, carrier: String)
}
