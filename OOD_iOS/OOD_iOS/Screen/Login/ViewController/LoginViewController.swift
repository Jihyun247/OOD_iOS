//
//  LoginViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var logoContainViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var guideLabel: UILabel!

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - parameter
    
    let deviceHeight = UIScreen.main.bounds.height/896
    
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        logoContainViewHeight.constant = 388*deviceHeight
        
        setTextFieldUI()
        setButtonUI()
        setLabelUI()
    }
    
    // MARK: - func
    func setTextFieldUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        emailTextField.font = UIFont.notoSansMedium(size: 14.0)
        passwordTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        passwordTextField.font = UIFont.notoSansMedium(size: 14.0)
        
    }
    
    func setButtonUI() {
        loginButton.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        loginButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        loginButton.titleLabel?.font = UIFont.notoSansBold(size: 16.0)
        loginButton.titleLabel?.textColor = .white
        
        signupButton.titleLabel?.font = UIFont.notoSansMedium(size: 11.0)
        signupButton.titleLabel?.textColor = .systemGray3
    }
    
    func setLabelUI() {
        guideLabel.font = UIFont.notoSansMedium(size: 12.0)
        guideLabel.textColor = UIColor(named: "OOD_blue")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBAction
    
    @IBAction func signupButton(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {return}
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        logoContainViewHeight.constant = 250*deviceHeight
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        logoContainViewHeight.constant = 388*deviceHeight
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
