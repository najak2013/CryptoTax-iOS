//
//  UserAuthViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/10.
//

import UIKit

class UserAuthViewController: BaseViewController {

    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var delegate: NextViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }, completion: nil)
        
        
        contentViewConst.constant = 0
        contentView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func backgroundClick(_ sender: Any) {
        closeModal()
    }
    @IBAction func okButton(_ sender: Any) {
        closeModal()
    }
    
    private func viewRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func closeModal() {
        UIView.animate(withDuration: 0.1, delay: 0, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }, completion: nil)

        contentViewConst.constant = contentView.frame.height
        contentView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.dismiss(animated: false)
            self.delegate?.nextView(self)
        })
    }
}




