//
//  MyAssetsViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyAssetsViewController: BaseViewController {

    @IBOutlet weak var AssetsContentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        AssetsContentTableView.rowHeight = UITableView.automaticDimension
        AssetsContentTableView.dataSource = self
        AssetsContentTableView.delegate = self
        cellRegister()
    }
    
    func cellRegister() {
        AssetsContentTableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
    }
    
    
    
}

extension MyAssetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
//
//            print(AssetsContentTableView.constraints.)
            
            cell.toggleView.frame = CGRect(x: 0, y: 0, width: 300, height: 50)

//
//            cell.toggleViewConstraint.constant = cell.stackView.frame.width / 3
//
//            cell.toggleView.layer.cornerRadius = cell.toggleSwitchView.layer.frame.height / 2
//            cell.toggleView.clipsToBounds = true
        
            return cell
        }
        return UITableViewCell()
    }
}

extension MyAssetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        print(cell.toggleButtons[0].frame.width)
    }
}

