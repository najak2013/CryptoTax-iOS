//
//  HomeViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit
import CryptoTaxLibs

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("안녕하세요.")
        
        let userInfo = [
            "userCI" : "김지태",
            "userAccessKey" : "",
            "userSecretKey" : ""
        ]
        
        // Do any additional setup after loading the view.
        CryptoTaxLibs.shared.getUserTaxInfo(userInfo: userInfo, CryptoHandler: { result in
            print("반환된 세금은 총 \(result)입니다.")
                    })

        print("세금 정보 요청 완료 결과를 기다려주세요.")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
