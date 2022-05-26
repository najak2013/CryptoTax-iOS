//
//  RegistNameViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/03.
//

import UIKit
import CryptoSwift
import AnyFormatKit
import Locksmith

//MARK: - 수정 예정
/**
 1. 텍스트필드 클릭하면 해당 작업 문구를 상단에 표시
 2. 주민번호 길이를 체크하는 부분을 수정 - 입력할 때는 상관없지만 다음 절차로 넘어갔다 다시 주민번호를 입력하면 길이가 부족해도 넘어가짐
 3. 이름 특수문자 들어간 경우 체크
 4. 전화번호 '-'를 표시해주기
 */


// bottomButtonLeading.constant = -10
//bottomButtonTrailing.constant = -10
//bottomButtonBottom

class UserRegistViewController: UIViewController, SelectCarrierProtocol {
    
    var addExchangeViewModel = AddExchangeViewModel()
    
    @IBOutlet weak var bottomButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var contentViewTop: NSLayoutConstraint!
    
    @IBOutlet var constraints: [NSLayoutConstraint]!
    @IBOutlet var textfields: [UITextField]!
    @IBOutlet var userInputViews: [UIView]!
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet var underLines: [UIView]!
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 57))
    var uiLabels: [UILabel] = []
    var placeholders: [String] = []
    var selectedTextfield: Int = 0
    
    var inputField: Int = 0
    var userCarrier: String = ""
    var userRegNo: String = ""
    var userName: String = ""
    var userPhone: String = ""
    
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
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
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
    
    
    var fontSize: CGFloat = 0
    
    //MARK: - Textfield 초기 설정
    func textfieldInit() {
        fontSize = textfields[0].font!.pointSize
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
    
    func createJsonData() -> String {
        var userJoinDictionary : [String: Any] = ["jumin": userRegNo, "name": ["ko": userName, "en": ["family": "", "given":""]], "phone": userPhone, "carrier": userCarrier, "home": [ "zipcode":"", "address":"", "tel":"" ], "company": [ "name":"", "zipcode":"", "address":"", "tel":"" ], "overseasTaxFlag":false ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: userJoinDictionary, options: [])
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
    
    func nextInputField() {
        if inputfieldCheck() && inputField < 3 {
            if inputField == 0 {
                textfields[1].becomeFirstResponder()
            }
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
                if let name = textfields[field].text {
                    userName = name
                }
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
            } else if field == 1 && textfieldEmptyCheck(textfieldArray: [textfields[field], textfields[4]]) {
                // 주민번호
                if let reg1 = textfields[field].text, let reg2 = textfields[4].text {
                    userRegNo = "\(reg1)\(reg2)"
                }
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[4])
            } else if field == 2 && textfieldEmptyCheck(textfieldArray: [textfields[field]]){
                // 통신사
                
                TextFieldUnderLineController().defaultUnderLine(underLine: underLines[field])
            } else if field == 3 && textfieldEmptyCheck(textfieldArray: [textfields[field]]) {
                // 전화번호
                if let number = textfields[field].text {
                    userPhone = number
                }
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
    
    //MARK: - Protocol 동작
    func getCarrier(_ vc: UIViewController, carrier: String) {
        TextFieldFloatLabelController().activeFloatLabel(textfield: textfields[2], userInputView: userInputViews[2], uiLabel: uiLabels[2], fontSize: fontSize)
        userCarrier = carrier
        textfields[2].text = carrier
        if inputField == 2 {
            nextInputField()
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if selectedTextfield == 0 {
            if self.view.frame.height <= 667 {
                contentViewTop.constant = -150 // Move view 150 points upward
            }
            if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                bottomButtonLeading.constant = -10
                bottomButtonTrailing.constant = -10
                bottomButtonBottom.constant = keyboardHeight
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        if selectedTextfield == 0 {
            if self.view.frame.height <= 667 {
                contentViewTop.constant = 30 // Move view to original position
            }
            bottomButtonLeading.constant = 24
            bottomButtonTrailing.constant = 24
            bottomButtonBottom.constant = 40
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UserRegistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextInputField()
        return true
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
            TextFieldFloatLabelController().activeFloatLabel(textfield: textfield, userInputView: userInputViews[textfieldIndex], uiLabel: uiLabels[textfieldIndex], fontSize: fontSize)
        }
        TextFieldUnderLineController().activeUnderLine(underLine: underLines[textfieldIndex])
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        if textfieldIndex != 4 {
            if textfield.text?.isEmpty ?? false {
                TextFieldFloatLabelController().defaultFloatLabel(textfield: textfield, uiLabel: uiLabels[textfieldIndex], placeholder: placeholders[textfieldIndex], fontSize: fontSize)
            }
        }
        TextFieldUnderLineController().defaultUnderLine(underLine: underLines[textfieldIndex])
    }
}

extension UserRegistViewController: NextViewProtocol {
    func nextView(_ vc: UIViewController) {
        
        
        
//        guard let smsAuthVC = self.storyboard?.instantiateViewController(withIdentifier: "SmsAuthViewController") as? SmsAuthViewController else { return }
        
        let userCIDIData = "9sEBGSVq+d2h82KQeRAWyS1sz6AWXZ/UKblv7+XbSIIuj7dQ6UDdOuAXvYWAQ6cb"
        
        UserConnection().userJoin(authInfo: userCIDIData, user: AES256Util.encrypt(string: createJsonData()), userJoinHandler: { result in
            switch result {
            case let .success(result):
                if result.code == "0000" {
                    guard let userSession = result.more.session else { return }
                    guard let userName = result.more.user?.name?.ko else { return }
                    let defaults = UserDefaults.standard
                    
                    defaults.set(userSession, forKey:"userSession")
                    defaults.set(userName, forKey:"userName")
                    
                    let alert = UIAlertController(title: "회원가입 성공", message: "userName: \(userName), userSession: \(userSession)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        
                        
                        
                        guard let smsAuthVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeConnectionViewController") as? ExchangeConnectionViewController else { return }
                        smsAuthVC.firstTimeView = true
                        
                        self.addExchangeViewModel.getCoinBalanceData { [weak self] in
                            guard let exchanges = self?.addExchangeViewModel.exchangeList else { return }
                            
                            var localList: [Keys] = []
                            var foreignList: [Keys] = []
                            var othersList: [Keys] = []
                            var isRegisteredList: [[Bool]] = [[],[],[]]
                            for exchange in exchanges {
                                guard let type = exchange.type else { return }
                                if type == "L" {
                                    localList.append(exchange)
                                    let isRegistered = exchange.isRegistered
                                    isRegisteredList[0].append(isRegistered ?? false)
                                } else if type == "F" {
                                    foreignList.append(exchange)
                                    let isRegistered = exchange.isRegistered
                                    isRegisteredList[1].append(isRegistered ?? false)
                                } else {
                                    othersList.append(exchange)
                                    let isRegistered = exchange.isRegistered
                                    isRegisteredList[2].append(isRegistered ?? false)
                                }
                            }
                            
                            smsAuthVC.isRegisteredList = isRegisteredList
                            smsAuthVC.localList = localList
                            smsAuthVC.foreignList = foreignList
                            smsAuthVC.othersList = othersList
                            
                            self?.navigationController?.pushViewController(smsAuthVC, animated: true)
                        }
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                } else {
                    var message: String
                    let errorcode = result.code
                    switch errorcode {
                    case "1011":
                        message = "회원가입 실패했습니다.\(errorcode)"
                    default:
                        message = "ErrorCode : " + errorcode
                    }
                    
                    let alert = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                }
            case let .failure(error):
                print(error)
            }
        })
        
        
        
        
        
    }
}




