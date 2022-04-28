//
//  PasswordViewController.swift
//  CryptoTax
//
//  Created by kimjitae on 2022/04/15.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var numberButtons: [UIButton]!
    
    
    @IBOutlet weak var faceIdButton: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUiInit()
        
        var _ = createCircleView(view: self.view, count: 4)
        
    }
    
    
    // MARK: - 화면 실행하면 UI 설정
    private func setUiInit() {
        // 상단 Title 설정
        titleLabel.text = "앱을 켜려면\n비밀번호를 눌러주세요"
        
        // 키패드에 랜덤 숫자를 넣기 위한 shuffled한 array
        let numbers: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
        // 키패드에 표시
        for (index, button) in numberButtons.enumerated() {
            button.setTitle("\(numbers[index])", for: .normal)
            button.addTarget(self, action: #selector(pushNumberButton), for: .touchUpInside)
        }
        
        
    }
    
    @objc private func pushNumberButton() {
        print("hi")
    }
    
    private func createCircleView(view: UIView, count: Int, width: Double = 18, height: Double = 18, spacing: Double = 16, centerX: CGFloat = 0, centerY: CGFloat = 0) -> [UIView] {
            
            // 원과 원 사이 거리
            let spacing: Double = spacing
            
            // 그려질 원의 수
            let count: Int = count
            
            // 화면 중앙
            let centerX = (view.frame.width / 2) - centerX
            let centerY = (view.frame.height / 2) + centerY
            
            // 그려질 원 크기
            let width: Double = width
            let height: Double = height
            
            // 왼쪽 좌표부터 시작하는 기준을 표시
            var startX: Double = centerX - (((width * Double(count)) + (spacing * Double((count - 1)))) / 2)
            let startY: Double = centerY

            var circleViewArray: [UIView] = []
            
            for _ in 0 ..< count {
                let rect = CGRect(x: startX, y: startY, width: width, height: height)
                let circle = UIView(frame: rect)
                circle.backgroundColor = .black
                circle.clipsToBounds = true
                circle.layer.cornerRadius = circle.frame.width / 2
                view.addSubview(circle)
                startX += (width + spacing)
                circleViewArray.append(circle)
            }
            
            return circleViewArray
        }
    
}
