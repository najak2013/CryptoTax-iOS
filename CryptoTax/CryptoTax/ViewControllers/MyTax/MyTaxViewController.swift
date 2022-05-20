//
//  MyTaxViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyTaxViewController: BaseViewController {
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    
    @IBOutlet weak var floatViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        floatViewBottomConstraint.constant = tabBarHeight!
        topLabel.text = "\(UserInfo().getUserName())님의 \n예상 세금이에요"
    }
    
    @IBAction func 버튼테스트(_ sender: Any) {
        print("안녕하세요.")
    }
    
    @IBAction func addExchange(_ sender: Any) {
        guard let addExchangeVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeConnectionViewController") as? ExchangeConnectionViewController else { return }
//        addExchangeVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(addExchangeVC, animated: true)
        
        
//        guard let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
//        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}
