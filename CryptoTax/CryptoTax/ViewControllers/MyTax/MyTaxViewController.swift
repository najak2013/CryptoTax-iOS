//
//  MyTaxViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyTaxViewController: BaseViewController {
    
    // 맨 위 테이블
    @IBOutlet weak var topLabel: UILabel!
    // 안내 문구
    @IBOutlet weak var remainLabel: UILabel!
    // 예상 세금
    @IBOutlet weak var expectedTaxLabel: UILabel!
    // 소득세
    @IBOutlet weak var incomeTaxLabel: UILabel!
    // 지방세
    @IBOutlet weak var localTaxLabel: UILabel!
    // 과세표준 금액
    @IBOutlet weak var taxBaseAmountLabel: UILabel!
    // 전체 수익금액
    @IBOutlet weak var totalRevenueAmountLabel: UILabel!
    // 구매한 금액
    @IBOutlet weak var purchaseAmountLabel: UILabel!
    // 거래소 수수료
    @IBOutlet weak var exchangeFeeLabel: UILabel!
    // 기타 비용
    @IBOutlet weak var otherCostLabel: UILabel!
    // 기본 공제
    @IBOutlet weak var basicDeductionLabel: UILabel!
    
    @IBOutlet weak var floatViewBottomConstraint: NSLayoutConstraint!
    
    // 연결 서비스
    @IBOutlet weak var exchangeCountLabel: UILabel!
    // 거래 코인 수
    @IBOutlet weak var currencyCountLabel: UILabel!
    // 거래 횟수
    @IBOutlet weak var transactionCountLabel: UILabel!
    
    var myTaxViewModel = MyTaxViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        floatViewBottomConstraint.constant = tabBarHeight!
        topLabel.text = "\(UserInfo().getUserName())님의 \n예상 세금이에요"
        
        myTaxViewModel.getMyTaxData { [weak self] in
            // 안내 문구
            self?.remainLabel.text = self?.myTaxViewModel.taxRemainingDays
            // 예상 세금
            self?.expectedTaxLabel.text = self?.myTaxViewModel.expectedTax?.expectedTax
            // 소득세
            self?.incomeTaxLabel.text = self?.myTaxViewModel.expectedTax?.incomeTax
            // 지방세
            self?.localTaxLabel.text = self?.myTaxViewModel.expectedTax?.localTax
            // 과세표준 금액
            let taxBase = self?.myTaxViewModel.expectedTax?.taxBaseAmount?.insertComma ?? "0"
            self?.taxBaseAmountLabel.text = "과세표준 금액은\n\(taxBase)원이에요"
            // 전체 수익금액
            self?.totalRevenueAmountLabel.text = self?.myTaxViewModel.expectedTax?.totalRevenueAmount
            // 구매한 금액
            self?.purchaseAmountLabel.text = self?.myTaxViewModel.expectedTax?.purchaseAmount
            // 거래소 수수료
            self?.exchangeFeeLabel.text = self?.myTaxViewModel.expectedTax?.exchangeFee
            // 기타 비용
            self?.otherCostLabel.text = self?.myTaxViewModel.expectedTax?.otherCost
            // 기본 공제
            self?.basicDeductionLabel.text = self?.myTaxViewModel.expectedTax?.basicDeduction
            
            
            // 연결 서비스
            let exchangeCount = self?.myTaxViewModel.taxBasis?.exchangeCount ?? 0
            self?.exchangeCountLabel.text = "\(exchangeCount)개"
            // 거래 코인 수
            let currencyCount = self?.myTaxViewModel.taxBasis?.currencyCount ?? 0
            self?.currencyCountLabel.text = "\(currencyCount)개"
            // 거래 횟수
            let transactionCount = self?.myTaxViewModel.taxBasis?.transactionCount ?? 0
            self?.transactionCountLabel.text = "\(transactionCount)개"
        }
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
