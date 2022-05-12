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
