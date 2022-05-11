//
//  RegistNameViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/03.
//

import UIKit

class UserRegistViewController: BaseViewController, UITextFieldDelegate, SelectCarrierProtocol {
    
    
    
    @IBOutlet var constraints: [NSLayoutConstraint]!
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
    
    func keyboardButtonInit() {
        button.backgroundColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0)
        button.setTitle("확인", for: .normal)
    }
    
    //MARK: - View 투명하게
    func viewAlphaInit() {
        for view in userInputViews {
            let viewIndex = userInputViews.firstIndex(of: view)!
            if viewIndex != 0 {
                view.alpha = 0
            }
        }
    }
    
    //MARK: - 주민번호 View 원형
    func circleViewInit() {
        for view in circleViews {
            view.layer.cornerRadius = view.layer.frame.width / 2
            view.clipsToBounds = true
        }
    }
    
    
    //MARK: - Textfield 초기 설정
    func textfieldInit() {
        for textfield in textfields {
            // textfield 델리게이트 설정
            textfield.delegate = self
            // textfield float을 위한 Label 생성
            createFloatLabel(textfield: textfield)
            // placeholder 정보 저장
            placeholders.append(textfield.placeholder!)
        }
    }
    
    //MARK: - Float 용 Label
    func createFloatLabel(textfield: UITextField) {
        let floatLabel = UILabel()
        floatLabel.frame = CGRect(x: textfield.frame.origin.x, y: textfield.frame.origin.y, width: textfield.frame.width, height: 18)
        floatLabel.font = floatLabel.font.withSize(14)
        floatLabel.text = textfield.placeholder
        floatLabel.textColor = UIColor(red: 0.5529, green: 0.5804, blue: 0.6275, alpha: 1.0)
        uiLabels.append(floatLabel)
    }
        
    //MARK: - 통신사 선택
    @IBAction func carrierButton(_ sender: Any) {
        guard let SelectCarrierModalVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCarrierModalViewController") as? SelectCarrierModalViewController else { return }
        SelectCarrierModalVC.modalPresentationStyle = .overFullScreen
        SelectCarrierModalVC.delegate = self
        present(SelectCarrierModalVC, animated: false, completion: nil)
    }
    
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
            userAuthVC.delegate = self
            present(userAuthVC, animated: false, completion: nil)
        }
    }
    
    
    //MARK: - Textfield Edit 여부
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
    
    //MARK: - 밑줄 활성화 여부
    func defaultUnderLine(textfieldIndex: Int, textfield: UITextField) {
                print("defaultUnderLine")
                underLines[textfieldIndex].backgroundColor = UIColor(red: 0.949, green: 0.9569, blue: 0.9647, alpha: 1.0)
            }
    func activeUnderLine(textfieldIndex: Int, textfield: UITextField) {
        print("activeUnderLine")
        underLines[textfieldIndex].backgroundColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0)
    }
    
    //MARK: - placeholder Float 여부
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
    
    //MARK: - Protocol 동작
    func getCarrier(_ vc: UIViewController, carrier: String) {
        activeFloatLabel(textfieldIndex: 2, textfield: textfields[2])
        textfields[2].text = carrier
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UserRegistViewController: NextViewProtocol {
    func nextView(_ vc: UIViewController) {
        guard let smsAuthVC = self.storyboard?.instantiateViewController(withIdentifier: "SmsAuthViewController") as? SmsAuthViewController else { return }
        self.navigationController?.pushViewController(smsAuthVC, animated: true)
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
