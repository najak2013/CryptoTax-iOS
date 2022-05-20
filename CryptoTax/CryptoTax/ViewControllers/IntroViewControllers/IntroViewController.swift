//
//  IntroViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/03.
//

import UIKit

class IntroViewController: UIViewController, NextViewProtocol {
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("제일 먼저 시작 페이지")
        mainLabel.text = "같은 수익, 다른 세금\n크립토택스"
        
//        let targetString3 = "to"
//        centerLabel.asColor(targetString: targetString3, color: UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0))
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let IntroPermissionModalVC = self.storyboard?.instantiateViewController(withIdentifier: "IntroPermissionModalViewController") as? IntroPermissionModalViewController else { return }
        IntroPermissionModalVC.modalPresentationStyle = .overFullScreen
        IntroPermissionModalVC.delegate = self
        present(IntroPermissionModalVC, animated: false, completion: nil)
    }
    
    func nextView(_ vc: UIViewController) {
        print("Hi")
        guard let userRegistVC = self.storyboard?.instantiateViewController(withIdentifier: "UserRegistViewController") as? UserRegistViewController else { return }
        self.navigationController?.pushViewController(userRegistVC, animated: true)
    }
}

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
