//
//  MyTaxViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyTaxViewController: BaseViewController {
    
    
    var myTaxViewModel = MyTaxViewModel()
    var addExchangeViewModel = AddExchangeViewModel()
    
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
    
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
#if NAJAK_DEV       /* Najak 20220526 DEV */
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainScrollView: UIScrollView!
#endif
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if NAJAK_DEV       /* Najak 20220526 DEV */
        self.mainScrollView.delegate = self
#endif
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        floatViewBottomConstraint.constant = tabBarHeight!
        topLabel.text = "\(UserInfo().getUserName())님의 \n예상 세금이에요"
        
        myTaxViewModel.getMyTaxData { [weak self] in
            guard let taxRemainingDays = self?.myTaxViewModel.taxRemainingDays else { return }
            guard let expectedTax = self?.myTaxViewModel.expectedTax?.expectedTax else { return }
            guard let incomeTax = self?.myTaxViewModel.expectedTax?.incomeTax else { return }
            guard let localTax = self?.myTaxViewModel.expectedTax?.localTax else { return }
            guard let taxBaseAmount = self?.myTaxViewModel.expectedTax?.taxBaseAmount else { return }
            guard let totalRevenueAmount = self?.myTaxViewModel.expectedTax?.totalRevenueAmount else { return }
            guard let purchaseAmount = self?.myTaxViewModel.expectedTax?.purchaseAmount else { return }
            guard let exchangeFee = self?.myTaxViewModel.expectedTax?.exchangeFee else { return }
            guard let otherCost = self?.myTaxViewModel.expectedTax?.otherCost else { return }
            guard let basicDeduction = self?.myTaxViewModel.expectedTax?.basicDeduction else { return }
            
            // 안내 문구
            self?.remainLabel.text = taxRemainingDays
            // 예상 세금
            self?.expectedTaxLabel.text = expectedTax.insertComma + "원"
            // 소득세
            self?.incomeTaxLabel.text = incomeTax.insertComma + "원"
            // 지방세
            self?.localTaxLabel.text = localTax.insertComma + "원"
            // 과세표준 금액
            self?.taxBaseAmountLabel.text = "과세표준 금액은\n\(taxBaseAmount.insertComma)원이에요"
            // 전체 수익금액
            self?.totalRevenueAmountLabel.text = totalRevenueAmount.insertComma + "원"
            // 구매한 금액
            self?.purchaseAmountLabel.text = purchaseAmount.insertComma + "원"
            // 거래소 수수료
            self?.exchangeFeeLabel.text = exchangeFee.insertComma + "원"
            // 기타 비용
            self?.otherCostLabel.text = otherCost.insertComma + "원"
            // 기본 공제
            self?.basicDeductionLabel.text = basicDeduction.insertComma + "원"
            
            
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
        pushExchangeConnectionView()
    }
    
    @IBAction func topRightButton(_ sender: Any) {
        pushExchangeConnectionView()
    }
    
    func pushExchangeConnectionView() {
        guard let addExchangeVC = self.storyboard?.instantiateViewController(withIdentifier: "ExchangeConnectionViewController") as? ExchangeConnectionViewController else { return }
        
        addExchangeViewModel.getCoinBalanceData { [weak self] in
            guard let exchanges = self?.addExchangeViewModel.exchangeList else { return }
            
            var localList: [Keys] = []
            var foreignList: [Keys] = []
            var othersList: [Keys] = []
            var isRegisteredList: [[Bool]] = [[],[],[]]
            for exchange in exchanges {
                guard let type = exchange.type else { return }
                if type == "L" {
                    localList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[0].append(isRegistered ?? false)
                } else if type == "F" {
                    foreignList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[1].append(isRegistered ?? false)
                } else {
                    othersList.append(exchange)
                    let isRegistered = exchange.isRegistered
                    isRegisteredList[2].append(isRegistered ?? false)
                }
            }
            
            addExchangeVC.isRegisteredList = isRegisteredList
            addExchangeVC.localList = localList
            addExchangeVC.foreignList = foreignList
            addExchangeVC.othersList = othersList
            
            self?.navigationController?.pushViewController(addExchangeVC, animated: true)
        }
    }
}

#if NAJAK_DEV       /* Najak 20220526 DEV */
extension MyTaxViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) / 3) {

            self.navigationViewHeight.constant = 100
            self.titleViewHeight.constant = 50
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.topLabel.text = "내 세금"
                self.view.layoutIfNeeded()
            }, completion: nil)

            
        } else {
            self.navigationViewHeight.constant = 182
            self.titleViewHeight.constant = 94
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.topLabel.text = "\(UserInfo().getUserName())님의 \n예상 세금이에요"
                self.view.layoutIfNeeded()
            }) { result in
                
            }
        }
    }
}
#endif
