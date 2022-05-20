//
//  SelfRegistViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import UIKit

class SelfRegistViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var contentViewTop: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonBottom: NSLayoutConstraint!

    @IBOutlet var userInputViews: [UIView]!
    @IBOutlet var underLines: [UIView]!
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet var textfields: [UITextField]!
    var uiLabels: [UILabel] = []
    var placeholders: [String] = []
    
    var section: Int = 0
    var exchange: String = ""
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textfieldInit()
        
        topLabel.text = "\(exchange)에서 생성한\nAPI Key를 입력해주세요"
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okButton(_ sender: Any) {
        var textfieldCheck: Bool = true
        for textfield in textfields {
            if textfield.text?.isEmpty ?? false {
                let textfieldIndex = textfields.firstIndex(of: textfield)!
                TextFieldUnderLineController().errorUnderLine(underLine: underLines[textfieldIndex])
                textfieldCheck = false
            }
        }
        
        if textfieldCheck {
            let exchangeData = ExchangeTestData.shared
            
            guard let accessKey = textfields[0].text else { return }
            guard let secretKey = textfields[1].text else { return }
                        
            ExchangeConnections().key(session: UserInfo().getUserSession(), exchangeName: exchange, accessKey: AES256Util.encrypt(string: accessKey), secretKey: AES256Util.encrypt(string: secretKey), exchangeKeyJoinHandler: { result in
                switch result {
                case let .success(result):
                    print("성공 결과 : ", result)
                    print("여기입니다.")
                    if result.code == "0000" {
                        
                        if !exchangeData.exchangeState[self.section][self.row] {
                            exchangeData.exchangeState[self.section][self.row] = true
                        }
                        
                        if !exchangeData.exchangeSelected[self.section].contains(self.exchange) {
                            exchangeData.exchangeSelected[self.section].append(self.exchange)
                        }
                        print("성공")
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        let alert = UIAlertController(title: "서버등록 실패", message: "Error Code : \(result.code)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: false, completion: nil)
                    }
                case let .failure(error):
                    print("실패 결과 : ", error)
                }
            })
            
            
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
    
    @objc func keyboardWillShow(_ sender: Notification) {
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
    @objc func keyboardWillHide(_ sender: Notification) {
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
    

    
    //MARK: - Textfield Edit 여부
    func textFieldDidBeginEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        TextFieldFloatLabelController().activeFloatLabel(textfield: textfield, userInputView: userInputViews[textfieldIndex], uiLabel: uiLabels[textfieldIndex], fontSize: fontSize)
        TextFieldUnderLineController().activeUnderLine(underLine: underLines[textfieldIndex])
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        let textfieldIndex = textfields.firstIndex(of: textfield)!
        if textfield.text?.isEmpty ?? false {
            TextFieldFloatLabelController().defaultFloatLabel(textfield: textfield, uiLabel: uiLabels[textfieldIndex], placeholder: placeholders[textfieldIndex], fontSize: fontSize)
        }
        TextFieldUnderLineController().defaultUnderLine(underLine: underLines[textfieldIndex])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


