//
//  SignupSecondViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/24.
//

import UIKit

class SignupSecondViewController: UIViewController {
    
    var nickname: String?
    var email: String?
    var password: String?
    var exCycle: Int?
    let pickerDictionary = ["주 2회": 2, "주 3회": 3, "주 4회": 4, "주 5회": 5, "주 6회": 6, "주 7회": 7]
    var key: String?
    var signupData: SignupData?
    
    @IBOutlet weak var exCycleTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTextFieldUI()
        setLabelUI()
        setButtonUI()
        createPickerView()
        createToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guideLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return super.canPerformAction(action, withSender: sender) && (action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy))
    }
    
    func setTextFieldUI() {
        
        exCycleTextField.delegate = self
        
        exCycleTextField.tintColor = .clear
        exCycleTextField.setBorderColorAndRadius(borderColor: UIColor(named: "OOD_blue"), borderWidth: 1.0, cornerRadius: 8.0)
        exCycleTextField.font = UIFont.notoSansMedium(size: 14.0)
    }
    
    func setLabelUI() {
        guideLabel.font = UIFont.notoSansMedium(size: 12.0)
        guideLabel.textColor = UIColor(named: "OOD_blue")
        guideLabel.isHidden = true
        
        explainLabel.font = UIFont.notoSansMedium(size: 16.0)
        explainLabel.textColor = .black
    }
    
    func setButtonUI() {
        doneButton.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        doneButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        let doneBtnTitle = NSMutableAttributedString(string: "완료")
        doneBtnTitle.addAttribute(.font, value: UIFont.notoSansBold(size: 16.0)!, range: NSRange(location: 0, length: doneBtnTitle.length))
        doneButton.setAttributedTitle(doneBtnTitle, for: .normal)
        doneButton.titleLabel?.textColor = .white
    }
    
    func showGuideLabel(_ msg: String) {
        self.guideLabel.text = msg
        self.guideLabel.isHidden = false
    }
    
    func signup(nickname: String, email: String, password: String, exCycle: Int) {
        
        APIService.shared.signup(nickname, email, password, pickerDictionary[key!]!) { result in
            switch result {
            case .success(let resultData):
                self.signupData = resultData as? SignupData

                guard let doneVC = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "SignupDoneViewController") as? SignupDoneViewController else {return}
                doneVC.nickname = self.signupData?.nickname
                self.navigationController?.pushViewController(doneVC, animated: true)

            case .requestErr(let message):
                if let msg = message as? String {
                    if msg == "필요한 값이 없습니다." {
                        self.showGuideLabel("모든 정보를 입력해주세요")
                    } else if msg == "이미 존재하는 닉네임입니다" {
                        self.showGuideLabel(msg)
                    } else if msg == "이미 존재하는 이메일 입니다." {
                        self.showGuideLabel("해당 이메일은 사용중입니다")
                    }
                }
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        
        if let exCycle = exCycleTextField.text, let exCycleInt = pickerDictionary[exCycle] {
            signup(nickname: nickname!, email: email!, password: password!, exCycle: exCycleInt)
        }
    }
    

}

extension SignupSecondViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(pickerDictionary.keys.sorted(by: <))[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.key = Array(pickerDictionary.keys.sorted(by: <))[row]
        exCycleTextField.text = self.key
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        exCycleTextField.inputView = pickerView
    }
    
    func createToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donePicker))
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        exCycleTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }

    @objc func cancelPicker() {
        exCycleTextField.text = nil
        self.view.endEditing(true)
    }
}


extension SignupSecondViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
