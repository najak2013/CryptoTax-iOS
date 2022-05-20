//
//  WellcomeViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/11.
//

import UIKit

class WellcomeViewController: UIViewController {

    
    var name: String = "김지태"
    @IBOutlet weak var wellcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wellcomeLabel.text = "\(name)님\n환영합니다!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(3)
        dismiss(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
