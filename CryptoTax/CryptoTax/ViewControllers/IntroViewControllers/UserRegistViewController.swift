//
//  RegistNameViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/03.
//

import UIKit
import CryptoSwift
import Alamofire


//MARK: - 수정 예정
/**
 1. 텍스트필드 클릭하면 해당 작업 문구를 상단에 표시
 2. 주민번호 길이를 체크하는 부분을 수정 - 입력할 때는 상관없지만 다음 절차로 넘어갔다 다시 주민번호를 입력하면 길이가 부족해도 넘어가짐
 3. 이름 특수문자 들어간 경우 체크
 4. 전화번호 '-'를 표시해주기
 */

class UserRegistViewController: BaseViewController, UITextFieldDelegate, SelectCarrierProtocol {
    
    @IBOutlet var constraints: [NSLayoutConstraint]!
    @IBOutlet var textfields: [UITextField]!
    
    
    
    @IBOutlet var userInputViews: [UIView]!
    
    
    
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet var underLines: [UIView]!
    
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 57))
    var uiLabels: [UILabel] = []
    var placeholders: [String] = []
    
    var inputField: Int = 0
    var userCarrier: String?
    
    @IBOutlet weak var bottomBuntton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAlphaInit()
        keyboardButtonInit()
        
        
        let dd = "970401"
        print(dd.count)
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
            uiLabels.append(TextFieldFloatLabelController().createFloatLabel(textfield: textfield))
            // placeholder 정보 저장
            placeholders.append(textfield.placeholder!)
        }
    }
    
    //MARK: - 통신사 선택
    @IBAction func carrierButton(_ sender: Any) {
        guard let SelectCarrierModalVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCarrierModalViewController") as? SelectCarrierModalViewController else { return }
        SelectCarrierModalVC.modalPresentationStyle = .overFullScreen
        SelectCarrierModalVC.delegate = self
        present(SelectCarrierModalVC, animated: false, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        nextInputField()
    }
    
    func nextInputField() {
        if inputfieldCheck() && inputField < 3 {
            inputField += 1
            if inputField != 4 {
                inputfieldAnimation()
            }
        } else if inputfieldCheck() && inputField == 3 {
            guard let userAuthVC = self.storyboard?.instantiateViewController(withIdentifier: "UserAuthViewController") as? UserAuthViewController else { return }
            userAuthVC.modalPresentationStyle = .overFullScreen
            userAuthVC.delegate = self
            present(userAuthVC, animated: false, completion: nil)
        }
    }
    
    func inputfieldCheck() -> Bool {
        var checkResult: Bool = true
        for field in 0 ... inputField {
            if field == 0 && textfieldEmptyCheck(textfieldArray: [textfields[field]]) {
                // 이름
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
            } else if field == 1 && textfieldEmptyCheck(textfieldArray: [textfields[field], textfields[4]]) {
                // 주민번호
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[4])
            } else if field == 2 && textfieldEmptyCheck(textfieldArray: [textfields[field]]){
                // 통신사
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
            } else if field == 3 && textfieldEmptyCheck(textfieldArray: [textfields[field]]) {
                // 전화번호
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
            } else {
                checkResult = false
            }
        }
        return checkResult
    }
    
    func textfieldEmptyCheck(textfieldArray: [UITextField]) -> Bool{
        var checkResult: Bool = true
        for textfield in textfieldArray {
            let textfieldIndex = textfields.firstIndex(of: textfield)!
            if textfield.text?.isEmpty ?? false {
                checkResult = false
                TextFieldUnderLineController().errorUnderLine(underLine: underLines[textfieldIndex])
            }
        }
        return checkResult
    }
    
    
    func inputfieldAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.userInputViews[self.inputField].alpha = 1
        }, completion: nil)
        for i in 0 ..< inputField {
            constraints[i].constant += 79
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textField)!
        if textfieldIndex == 1 {
            guard let text = textField.text else { return }
            if text.count == 6 {
                textfields[4].becomeFirstResponder()
            }
        } else if textfieldIndex == 4 {
            guard let text = textField.text else { return }
            if text.count == 1 {
                textField.resignFirstResponder()
                if inputField == 1 {
                    nextInputField()
                }
            }
        }
            
        
        
    }
    
    //MARK: - Textfield Edit 여부
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        if textfieldIndex != 4 {
            TextFieldFloatLabelController().activeFloatLabel(textfield: textfield, userInputView: userInputViews[textfieldIndex], uiLabel: uiLabels[textfieldIndex])
        }
        TextFieldUnderLineController().activeUnderLine(underLine: underLines[textfieldIndex])
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        if textfieldIndex != 4 {
            if textfield.text?.isEmpty ?? false {
                TextFieldFloatLabelController().defaultFloatLabel(textfield: textfield, uiLabel: uiLabels[textfieldIndex], placeholder: placeholders[textfieldIndex])
            }
        }
        TextFieldUnderLineController().defaultUnderLine(underLine: underLines[textfieldIndex])
    }
    
    //MARK: - Protocol 동작
    func getCarrier(_ vc: UIViewController, carrier: String) {
        TextFieldFloatLabelController().activeFloatLabel(textfield: textfields[2], userInputView: userInputViews[2], uiLabel: uiLabels[2])
        textfields[2].text = carrier
        if inputField == 2 {
            nextInputField()
        }
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




