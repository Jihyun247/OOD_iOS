//
//  SignupDoneViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/24.
//

import UIKit

class SignupDoneViewController: UIViewController {
    
    var nickname: String?
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var signupDoneLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelUI()
        setButtonUI()
    }
    
    func setLabelUI() {
        signupDoneLabel.font = UIFont.notoSansMedium(size: 26.0)
        signupDoneLabel.textColor = .black
        signupDoneLabel.text = "가입 완료!"
        
        signupDoneLabel.font = UIFont.notoSansMedium(size: 24.0)
        signupDoneLabel.textColor = .black
        signupDoneLabel.text = "\(nickname!)님"
    }
    
    func setButtonUI() {
        doneButton.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        doneButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        let doneBtnTitle = NSMutableAttributedString(string: "완료")
        doneBtnTitle.addAttribute(.font, value: UIFont.notoSansBold(size: 16.0)!, range: NSRange(location: 0, length: doneBtnTitle.length))
        doneButton.setAttributedTitle(doneBtnTitle, for: .normal)
        doneButton.titleLabel?.textColor = .white
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}
