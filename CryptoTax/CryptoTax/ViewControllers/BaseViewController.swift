//
//  BaseViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit
import Locksmith

class BaseViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userRegist = AppFirstTime().userNeedToRegist()
        if userRegist {
            print("여기 실행")
            guard let IntroVC = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as? UINavigationController else { return }
            IntroVC.modalPresentationStyle = .fullScreen
            present(IntroVC, animated: false, completion: nil)
        } else {
            print(UserInfo().getUserName())
            print(UserInfo().getUserSession())
        }
    }
}
