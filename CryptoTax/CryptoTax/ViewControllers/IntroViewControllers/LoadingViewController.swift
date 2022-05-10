//
//  LoadingViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/10.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var userName: String = "김지태"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        topLabel.text = "\(userName)님의\n거래소 거래내역을\n찾고 있어요"
        
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

}
