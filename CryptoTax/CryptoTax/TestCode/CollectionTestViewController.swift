//
//  CollectionTextViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/12.
//

import UIKit

class ExchangeConnectionViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var list = ["업비트", "빗썸", "코인원", "코빗" ,"고팍스", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        
        
//        borderView.layer.borderColor = UIColor.black.cgColor
//        borderView.layer.borderWidth = 10
    
        myCollectionView.collectionViewLayout = createCompositionalLayout()
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
}

extension ExchangeConnectionViewController {
    
    fileprivate func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
//
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(80))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0)
            
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        }
        
        return layout
    }
}

extension ExchangeConnectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestCollectionViewCell
                
        cell.myLabel.text = list[indexPath.row]
        return cell
    }
    
    
}

extension ExchangeConnectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(list[indexPath.row])
    }
    
}

class TestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myLabel: UILabel!
    
    
    
    
}
