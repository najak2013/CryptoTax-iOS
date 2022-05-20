//
//  MyAssetsViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/14.
//

import UIKit

class MyAssetsViewController: BaseViewController {

    @IBOutlet weak var AssetsContentTableView: UITableView!
    
    let spaceBetweenSections = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        AssetsContentTableView.rowHeight = UITableView.automaticDimension
        AssetsContentTableView.dataSource = self
        AssetsContentTableView.delegate = self
        cellRegister()
        
        
        BalanceConnections().coin(session: UserInfo().getUserSession(), CoinBalanceHandler: { result in
            switch result {
            case let .success(result):
                print("성공 결과 : ", result)
            case let .failure(error):
                print("실패 결과 : ", error)
            }
            
        })
    }
    
    func cellRegister() {
        AssetsContentTableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
    }
    
    
    
}

extension MyAssetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "총 9개의 자산을\n가지고 있어요"
            return cell
        } else if indexPath.section == 3 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "CoinOptionTableViewCell", for: indexPath) as! CoinOptionTableViewCell
            return cell
        } else if indexPath.section == 4 {
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.titleLabel.text = "총 9개의 자산을 가지고 있어요"
            return cell
        }
        return UITableViewCell()
    }
}

extension MyAssetsViewController: UITableViewDelegate {
}

