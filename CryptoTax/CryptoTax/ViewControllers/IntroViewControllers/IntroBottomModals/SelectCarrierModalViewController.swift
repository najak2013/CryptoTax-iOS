//
//  SelectCarrierModalViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/09.
//

import UIKit

class SelectCarrierModalViewController: UIViewController {
    
    let carriers: [String] = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"]
    var delegate: SelectCarrierProtocol?
    
    
    @IBOutlet weak var carrierTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.size.height)
        if UIScreen.main.bounds.size.height < 667 {
            carrierTableView.isScrollEnabled = true
        }
        carrierTableView.dataSource = self
        carrierTableView.delegate = self
        carrierTableView.register(UINib(nibName: "carrierTableViewCell", bundle: nil), forCellReuseIdentifier: "carrierTableViewCell")
        // Do any additional setup after loading the view.
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
        dismiss(animated: true)
    }
}
