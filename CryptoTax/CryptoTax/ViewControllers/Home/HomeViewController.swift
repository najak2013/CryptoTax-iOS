//
//  HomeViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit
//import CryptoTaxLibs

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guard let IntroVC = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as? UINavigationController else { return }
        IntroVC.modalPresentationStyle = .fullScreen
        present(IntroVC, animated: false, completion: nil)
        
//        let userInfo = [
//            "userCI" : "김지태",
//            "userAccessKey" : "",
//            "userSecretKey" : ""
//        ]
//
//        // Do any additional setup after loading the view.
//        CryptoTaxLibs.shared.getUserTaxInfo(userInfo: userInfo, CryptoHandler: { result in
//            print("반환된 세금은 총 \(result)입니다.")
//                    })
//
//        print("세금 정보 요청 완료 결과를 기다려주세요.")

    }
}
