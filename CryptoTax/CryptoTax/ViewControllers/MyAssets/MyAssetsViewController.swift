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
    
    var myAssetsViewModel = MyAssetsViewModel()
    var coinCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AssetsContentTableView.rowHeight = UITableView.automaticDimension
        AssetsContentTableView.dataSource = self
        AssetsContentTableView.delegate = self
        cellRegister()
        
        
        
        myAssetsViewModel.getCoinCount { [weak self] in
            self?.coinCount = self?.myAssetsViewModel.coinCount ?? 0
            DispatchQueue.main.async {
                self?.AssetsContentTableView.reloadData()
            }
        }
    }
    
    func cellRegister() {
        AssetsContentTableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "TopTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTitleTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
        AssetsContentTableView.register(UINib(nibName: "CoinOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinOptionTableViewCell")
    }
    
    
    
}

extension MyAssetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            //MARK: - 그래프 그려지는 Cell
            return 1
        } else if section == 1 {
            //MARK: - Cell 사이 간격
            return 1
        } else if section == 2 {
            //MARK: - 코인별 Title
            return 1
        } else if section == 3 {
            //MARK: - 코인별 리스트
            
            
            return 1
        } else if section == 4 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: - 그래프 그려지는 Cell
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            return cell
        } else if indexPath.section == 1 {
            //MARK: - Cell 사이 간격
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell", for: indexPath) as! SpaceTableViewCell
            return cell
        } else if indexPath.section == 2 {
            //MARK: - 코인별 Title
            let cell = AssetsContentTableView.dequeueReusableCell(withIdentifier: "TopTitleTableViewCell", for: indexPath) as! TopTitleTableViewCell
            cell.heightConstraint.constant = 124
            cell.titleLabel.text = "총 \(coinCount)개의 자산을\n가지고 있어요"
            return cell
        } else if indexPath.section == 3 {
            //MARK: - 코인별 리스트
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

