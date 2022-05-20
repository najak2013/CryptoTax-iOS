//
//  LoadingViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/10.
//

import UIKit

//MARK: - 수정 예정
/**
 1. 서버를 통해서 유저 세금 정보를 조회하기
 2. 끝나면 다음으로 넘어가기
 */

class LoadingViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var userName: String = "김지태"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = "\(userName)님의\n거래소 거래내역을\n찾고 있어요"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 0...100 {
            self.percentageLabel.text = "\(i)% 완료"
        }
        
        guard let wellcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WellcomeViewController") as? WellcomeViewController else { return }
//        wellcomeVC.name = userName
        self.navigationController?.pushViewController(wellcomeVC, animated: true)
    }
    
}
