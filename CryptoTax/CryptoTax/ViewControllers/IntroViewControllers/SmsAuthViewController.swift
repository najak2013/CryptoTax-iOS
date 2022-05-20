//
//  smsAuthViewController.swift
//  Pods
//
//  Created by kimjitae on 2022/05/11.
//

import UIKit

//MARK: - 수정 예정
/**
 1. 텍스트 필드 빈 값 체크
 2. 숫자 6자리 인식으로 고정하기
 3. 숫자만 입력받게하기
 4. 3분 카운트 다운 기능하기
 */

class SmsAuthViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var name: String = "김지태"

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "\(name)님이 문자로 받은\n인증번호 6자리를 입력해주세요"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButton(_ sender: Any) {
        guard let loadingVC = self.storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else { return }
        self.navigationController?.pushViewController(loadingVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

