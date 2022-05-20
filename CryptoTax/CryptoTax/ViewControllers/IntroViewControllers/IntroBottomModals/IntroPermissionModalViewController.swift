//
//  introPermissionModalViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/09.
//

import UIKit

class IntroPermissionModalViewController: UIViewController {


    var delegate: NextViewProtocol?
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModalViewRadius().viewRadius(contentView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }, completion: nil)
        
        
        contentViewConst.constant = 0
        contentView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    
    @IBAction func backgroundClick(_ sender: Any) {
        closeModal(closeModalHandler: {
        })
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        closeModal(closeModalHandler: {
            self.delegate?.nextView(self)
        })
    }
    
    
    func closeModal(closeModalHandler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1, delay: 0, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }, completion: nil)

        contentViewConst.constant = contentView.frame.height
        contentView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.dismiss(animated: false)
            closeModalHandler()
        })
    }
    
    @IBAction func privacyPolicyButton(_ sender: Any) {
        print("개인정보처리방침")
    }
    
}


extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
          attributedText = attributedString
        }
    }
}
//
//// UIDevice 익스텐션으로 만들어줍니다.
//extension UIDevice {
//    var hasNotch: Bool {
//        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
//        return bottom > 0
//    }
//}
