//
//  CollectionTextViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/12.
//

import UIKit
import CryptoSwift
import Locksmith

class ExchangeConnectionViewController: UIViewController {
    @IBOutlet weak var ExchangeCollectionView: UICollectionView!
    @IBOutlet weak var animationBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet var sectionButtons: [UIButton]!
    @IBOutlet weak var bottomButtonView: UIView!
    
    var userCIDIData: String = ""
    var userJoinData: String = ""

    
    var testExchangeData = ExchangeTestData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExchangeCollectionView.delegate = self
        ExchangeCollectionView.dataSource = self
        
        
        for button in sectionButtons {
            button.addTarget(self, action: #selector(sectionAnimation), for: .touchUpInside)
        }
        
        
        ExchangeCollectionView.contentInset.bottom = 100
        ExchangeCollectionView.collectionViewLayout = createCompositionalLayout()
        
        bottomViewHide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getExchangeList()
        ExchangeCollectionView.reloadData()
    }
    
    @objc func sectionAnimation(sender: UIButton) {
        animationBarConstraint.constant = sender.frame.width * CGFloat(sender.tag)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func bottomViewHide() {
        let selectedExchangeCount: Int = getClientSelectCount()
        
        if selectedExchangeCount > 0 {
            bottomButtonView.isHidden = false
        } else {
            bottomButtonView.isHidden = true
        }
        connectButton.setTitle("\(selectedExchangeCount)개 연결하기", for: .normal)
    }
    
    func getClientSelectCount() -> Int {
        return testExchangeData.exchangeSelected[0].count + testExchangeData.exchangeSelected[1].count + testExchangeData.exchangeSelected[2].count
    }
    
    func getExchangeList() {
        BalanceConnections().exchange(session: UserInfo().getUserSession(), exchange: "", BalanceExchangeHandler: { (result) in
            switch result {
            case let .success(result):
                if result.code == "0000" {
                    
                    guard let exchanges = result.more.exchange else { return }
                    for exchange in exchanges {
                        print(exchange)
                    }
                } else {
                    let alert = UIAlertController(title: "초회 실패", message: "Error Code : \(result.code)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                }
            case let .failure(error):
                print(error)
            }
        })
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func exchangeConnectButton(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        
        guard let loadingVC = self.storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else { return }
        self.navigationController?.pushViewController(loadingVC, animated: true)
    
    }
    
    
}

extension ExchangeConnectionViewController {
    // 가로 개수를 유동적으로
    fileprivate func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(80))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 10, trailing: 4)
            
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(90))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            return section
        }
        
        return layout
    }
}

extension ExchangeConnectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return testExchangeData.exchangeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testExchangeData.exchangeList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let exchangeName = testExchangeData.exchangeList[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCollectionViewCell", for: indexPath) as! ExchangeCollectionViewCell
        
        
        if testExchangeData.exchangeSelected[indexPath.section].contains(exchangeName) {
            cell.cellContentView.layer.borderColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0).cgColor
            cell.cellContentView.layer.borderWidth = 2
        } else {
            cell.cellContentView.layer.borderWidth = 0
        }
        bottomViewHide()
        cell.exchangeName = exchangeName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let titleText = ["국내 거래소", "해외 거래소", "지갑·NFT"]
        switch kind {
            case UICollectionView.elementKindSectionHeader:
            let headerView = ExchangeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExchangeHeaderView", for: indexPath) as! ExchangeHeaderView
            let sectionNumber = indexPath.section
            headerView.selectAllButton.tag = sectionNumber
            headerView.titleLabel.text = titleText[sectionNumber]
//                headerView.selectAllButton.addTarget(self, action: #selector(self.buttonText), for: .touchUpInside)
                return headerView
            default:
                assert(false, "응 아니야")
        }
    }
}

extension ExchangeConnectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedExchange = testExchangeData.exchangeList[indexPath.section][indexPath.row]
        
        if testExchangeData.exchangeState[indexPath.section][indexPath.row] {
            if testExchangeData.exchangeSelected[indexPath.section].contains(selectedExchange) {
                print("선택한 거래소를 제거합니다.")
                if let index = testExchangeData.exchangeSelected[indexPath.section].firstIndex(of: selectedExchange) {
                    testExchangeData.exchangeSelected[indexPath.section].remove(at: index)
                }
            } else {
                print("선택한 거래소를 추가합니다.")
                testExchangeData.exchangeSelected[indexPath.section].append(selectedExchange)
            }
        } else {
            print("선택한 거래소를 수동으로 입력해주세요.")
            guard let selfRegistVC = self.storyboard?.instantiateViewController(withIdentifier: "SelfRegistViewController") as? SelfRegistViewController else { return }
            selfRegistVC.section = indexPath.section
            selfRegistVC.row = indexPath.row
            selfRegistVC.exchange = selectedExchange
            self.navigationController?.pushViewController(selfRegistVC, animated: true)
        }
        ExchangeCollectionView.reloadData()
    }
}

class ExchangeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var exchangeNameLabel: UILabel!
    
    var exchangeName: String = "" {
        didSet {
            exchangeNameLabel.text = exchangeName
        }
    }
}

class ExchangeHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectAllButton: UIButton!
    override func awakeFromNib() {
       super.awakeFromNib()
    }
}
