//
//  MyTaxViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyTaxViewController: BaseViewController {

    @IBOutlet weak var floatViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        floatViewBottomConstraint.constant = tabBarHeight!
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
