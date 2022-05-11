//
//  SelectCarrierModalViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/09.
//

import UIKit

class SelectCarrierModalViewController: BaseViewController {
    
    let carriers: [String] = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"]
    var delegate: SelectCarrierProtocol?
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    
    @IBOutlet weak var carrierTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRadius(contentView)
        
        carrierTableView.dataSource = self
        carrierTableView.delegate = self
        carrierTableView.register(UINib(nibName: "carrierTableViewCell", bundle: nil), forCellReuseIdentifier: "carrierTableViewCell")
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
    
    private func viewRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @IBAction func backgroundClick(_ sender: Any) {
        closeModal()
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
        })
    }
}

extension SelectCarrierModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carriers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "carrierTableViewCell") as? carrierTableViewCell {
            cell.carrierLabel.text = carriers[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension SelectCarrierModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCarrier(self, carrier: carriers[indexPath.row])
        self.closeModal()
    }
}
