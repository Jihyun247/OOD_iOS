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
    var loginData: LoginData?
    
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoContainViewHeight.constant = deviceHeight * 388
        
        setTextFieldUI()
        setButtonUI()
        setLabelUI()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        let loginBtnTitle = NSMutableAttributedString(string: "로그인")
        loginBtnTitle.addAttribute(.font, value: UIFont.notoSansBold(size: 16.0)!, range: NSRange(location: 0, length: loginBtnTitle.length))
        loginButton.setAttributedTitle(loginBtnTitle, for: .normal)
        loginButton.titleLabel?.textColor = .white
        
        let signupBtnTitle = NSMutableAttributedString(string: "회원가입 하기")
        signupBtnTitle.addAttribute(.font, value: UIFont.notoSansMedium(size: 11.0)!, range: NSRange(location: 0, length: signupBtnTitle.length))
        signupButton.setAttributedTitle(signupBtnTitle, for: .normal)
        signupButton.titleLabel?.textColor = .systemGray2
    }
    
    func setLabelUI() {
        guideLabel.font = UIFont.notoSansMedium(size: 12.0)
        guideLabel.textColor = UIColor(named: "OOD_blue")
        guideLabel.isHidden = true
    }
    
    func showGuideLabel(_ msg: String) {
        self.guideLabel.text = msg
        self.guideLabel.isHidden = false
    }
    
    func login(email: String, password: String) {
        APIService.shared.login(email, password) { result in
            switch result {
            case .success(let resultData):
                self.loginData = resultData as? LoginData
                
                if let data = self.loginData {
                    UserDefaults.standard.setValue(data.token, forKey: "token")
                    
                    guard let certiVC = UIStoryboard(name: "Certification", bundle: nil).instantiateViewController(withIdentifier: "CertiViewController") as? CertiViewController else {return}
                    certiVC.modalPresentationStyle = .fullScreen
                    self.present(certiVC, animated: true, completion: nil)
                }
            case .requestErr(let message):
                if let msg = message as? String {
                    if msg == "필요한 값이 없습니다." {
                        self.showGuideLabel("이메일과 비밀번호 모두 입력해주세요")
                    } else if msg == "존재하지않는 유저 id 입니다." {
                        self.showGuideLabel("없는 회원 정보입니다")
                    } else if msg == "비밀번호가 일치하지 않습니다" {
                        self.showGuideLabel(msg)
                    }
                }
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBAction
    
    @IBAction func signupButton(_ sender: UIButton) {

        guard let signupVC = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {return}
        
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.view.endEditing(true)
        if let email = emailTextField.text, let password = passwordTextField.text {
            login(email: email, password: password)
        }
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
