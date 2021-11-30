//
//  SignupFirstViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/24.
//

import UIKit

class SignupFirstViewController: UIViewController {
    
    var nextBtnDelegate: NextBtnDelegate?
    let deviceHeight = UIScreen.main.bounds.height/896
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var labelContainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelContainViewHeight.constant = 120*deviceHeight

        setTextFieldUI()
        setLabelUI()
        setButtonUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setTextFieldUI() {
        
        nicknameTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        nicknameTextField.font = UIFont.notoSansMedium(size: 14.0)
        emailTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        emailTextField.font = UIFont.notoSansMedium(size: 14.0)
        passwordTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        passwordTextField.font = UIFont.notoSansMedium(size: 14.0)
        passwordTextField.isSecureTextEntry = true
        
        nicknameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func setLabelUI() {
        guideLabel.font = UIFont.notoSansMedium(size: 12.0)
        guideLabel.textColor = UIColor(named: "OOD_blue")
        guideLabel.isHidden = false
        
        explainLabel.font = UIFont.notoSansMedium(size: 16.0)
        explainLabel.textColor = .black
    }
    
    func setButtonUI() {
        nextButton.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        nextButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        let nextBtnTitle = NSMutableAttributedString(string: "다음")
        nextBtnTitle.addAttribute(.font, value: UIFont.notoSansBold(size: 16.0)!, range: NSRange(location: 0, length: nextBtnTitle.length))
        nextButton.setAttributedTitle(nextBtnTitle, for: .normal)
        nextButton.titleLabel?.textColor = .white
        
        
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        self.isEditing = false
        if let nickname = nicknameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {

            nextBtnDelegate?.nextBtnClicked(nickname: nickname, email: email, password: password)
        }
    }
    

}

extension SignupFirstViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.labelContainViewHeight.constant = 0
        self.guideLabel.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.labelContainViewHeight.constant = 120*deviceHeight
        self.guideLabel.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

