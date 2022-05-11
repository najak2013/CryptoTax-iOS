//
//  LoadingViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/10.
//

import UIKit

class LoadingViewController: BaseViewController {

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
        wellcomeVC.name = userName
        self.navigationController?.pushViewController(wellcomeVC, animated: true)
    }
    
}
