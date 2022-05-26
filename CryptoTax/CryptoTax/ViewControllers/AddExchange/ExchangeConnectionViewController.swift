//
//  CollectionTextViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/12.
//

import UIKit
import CryptoSwift
import Locksmith

class ExchangeConnectionViewController: UIViewController, AddExchangeToServer {
    func exchange(_ vc: UIViewController, section: Int, row: Int) {
        print("델리게이트 실행2")
        isRegisteredList[section][row] = true
        ExchangeCollectionView.reloadData()
    }
    
    
    @IBOutlet weak var ExchangeCollectionView: UICollectionView!
    @IBOutlet weak var animationBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet var sectionButtons: [UIButton]!
    @IBOutlet weak var bottomButtonView: UIView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var firstTimeView: Bool = false
    
    var userCIDIData: String = ""
    var userJoinData: String = ""

    var testExchangeData = ExchangeTestData.shared
    
    var sectionList: [String] = []
    var localList: [Keys] = []
    var foreignList: [Keys] = []
    var othersList: [Keys] = []
    var isRegisteredList: [[Bool]] = [[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstTimeView {
            backImageView.isHidden = true
            backButton.isHidden = true
        }
        
        ExchangeCollectionView.delegate = self
        ExchangeCollectionView.dataSource = self
        
        for button in sectionButtons {
            button.addTarget(self, action: #selector(sectionAnimation), for: .touchUpInside)
        }
        
        ExchangeCollectionView.contentInset.bottom = 100
        ExchangeCollectionView.collectionViewLayout = createCompositionalLayout()
        bottomViewHide()
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
        return isRegisteredList[0].filter { $0 == true }.count + isRegisteredList[1].filter { $0 == true }.count + isRegisteredList[2].filter { $0 == true }.count
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return localList.count
        } else if section == 1 {
            return foreignList.count
        } else if section == 2 {
            return othersList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCollectionViewCell", for: indexPath) as! ExchangeCollectionViewCell
        if indexPath.section == 0 {
            if isRegisteredList[0][indexPath.row] {
                cell.cellContentView.layer.borderColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0).cgColor
                cell.cellContentView.layer.borderWidth = 2
            } else {
                cell.cellContentView.layer.borderWidth = 0
            }
            
            bottomViewHide()
            
            let exchangeName: String = localList[indexPath.row].name?.ko ?? localList[indexPath.row].name?.en ?? "Error"
            cell.exchangeName = exchangeName
//            return cell
        } else if indexPath.section == 1 {
            if isRegisteredList[indexPath.section][indexPath.row] {
                cell.cellContentView.layer.borderColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0).cgColor
                cell.cellContentView.layer.borderWidth = 2
            } else {
                cell.cellContentView.layer.borderWidth = 0
            }
            
            bottomViewHide()
            let exchangeName: String = foreignList[indexPath.row].name?.ko ?? foreignList[indexPath.row].name?.en ?? "Error"
            cell.exchangeName = exchangeName
//            return cell
        } else if indexPath.section == 2 {
            if isRegisteredList[indexPath.section][indexPath.row] {
                cell.cellContentView.layer.borderColor = UIColor(red: 0.2549, green: 0.4078, blue: 0.9647, alpha: 1.0).cgColor
                cell.cellContentView.layer.borderWidth = 2
            } else {
                cell.cellContentView.layer.borderWidth = 0
            }
            bottomViewHide()
            let exchangeName: String = othersList[indexPath.row].name?.ko ?? othersList[indexPath.row].name?.en ?? "Error"
            cell.exchangeName = exchangeName
//            return cell
        }
        
        
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
                assert(false, "패스")
        }
        return UICollectionReusableView()
    }
}

extension ExchangeConnectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let isRegistered = localList[indexPath.row].isRegistered else { return }
            guard let exchangeName = localList[indexPath.row].name else { return }
            if isRegistered {
                print("이미된 곳")
            } else {
                print("선택한 거래소를 수동으로 입력해주세요.")
                
                guard let selfRegistVC = self.storyboard?.instantiateViewController(withIdentifier: "SelfRegistViewController") as? SelfRegistViewController else { return }
                selfRegistVC.delegate = self
                selfRegistVC.section = indexPath.section
                selfRegistVC.row = indexPath.row
                selfRegistVC.exchange = exchangeName
                self.present(selfRegistVC, animated: true, completion: nil)
            }
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
