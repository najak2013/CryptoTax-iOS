//
//  introPermissionModalViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/05/09.
//

import UIKit

class IntroPermissionModalViewController: UIViewController {


    var delegate: NextViewProtocol?
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentViewConst: NSLayoutConstraint!
    
    
    //MARK: - Option
    // Animation 적용 여부. false는 StartColor가 메인 색상이됨
    let animationEnable: Bool = true
    
    // 진입/퇴장 배경 흐려짐 속도
    let fadeInSec: Double = 0.5
    let fadeOutSec: Double = 0.1
    
    // 진입/퇴장 배경 흐려짐 지연
    let fadeInDelaySec: Double = 0.0
    let fadeOutDelaySec: Double = 0.0
    
    // backgroundColor startColor -> fadeInColor -> fadeOutcolor
    let startColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    let fadeInColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    let fadeOutColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(contentView.bounds.height)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
//        contentViewConst.constant = 34 + contentView.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if animationEnable {
            UIView.animate(withDuration: 0.3, delay: 0, animations: {
                self.backgroundView.backgroundColor = self.fadeInColor
            }, completion: nil)
            
            
            print(UIDevice.current.hasNotch)
            
//
            var constantValue: CGFloat = 34
            if UIDevice.current.hasNotch {
                constantValue = 0
            }
//
//            contentViewConst.constant = constantValue
//            contentView.setNeedsUpdateConstraints()
//            UIView.animate(withDuration: fadeInSec, delay: fadeInDelaySec, animations: {
//                self.view.layoutIfNeeded()
//            }, completion: nil)
        }
    }

    
    
    @IBAction func closeViewButton(_ sender: Any) {
        closeModal()
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        closeModal()
    }
    
    func closeModal() {
        if animationEnable {
            UIView.animate(withDuration: fadeOutSec, delay: fadeOutDelaySec, animations: {
                self.view.backgroundColor = self.fadeOutColor
            }, completion: nil)


        }
        dismiss(animated: false)
//        delegate?.nextView(self)
    }
}


// UIDevice 익스텐션으로 만들어줍니다.
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
