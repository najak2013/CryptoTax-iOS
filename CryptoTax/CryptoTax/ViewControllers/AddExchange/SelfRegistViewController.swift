//
//  SelfRegistViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/13.
//

import UIKit

class SelfRegistViewController: UIViewController {
    
    
    @IBOutlet weak var contentViewTop: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


func getPublicIPAddress() -> String {
    var publicIP = ""
    do {
        try publicIP = String(contentsOf: URL(string: "https://www.bluewindsolution.com/tools/getpublicip.php")!, encoding: String.Encoding.utf8)
        publicIP = publicIP.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    catch {
        print("Error: \(error)")
    }
    return publicIP
}
