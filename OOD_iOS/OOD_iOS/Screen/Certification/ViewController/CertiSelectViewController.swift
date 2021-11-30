//
//  CertiSelectViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import UIKit

enum ButtonCollectionType {
case sport, intensity, evalu
}

class CertiSelectViewController: UIViewController {
    
    var timestampImage: UIImage?
    var exerciseTime: String?
    var token: String?
    var certiId: Int? {
        didSet {
            guard let userToken = token, let image = timestampImage, let id = certiId else {return}
            
            if certiId != 0 {
                uploadImage(userToken, image, id)
            } else {
                print("certiId를 가져오지 못함")
            }
        }
    }
    var keyboardHeight: CGFloat?
    
    let deviceHeight = UIScreen.main.bounds.height/896
    let grey = UIColor(red: 221/255, green: 225/255, blue: 229/255, alpha: 1)
    var sportsBtnIdx: Int?
    var intensityBtnIdx: Int?
    var evaluBtnIdx: Int?
    
    @IBOutlet weak var commentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var naviTitleLabel: UILabel!
    
    
    @IBOutlet var guideLabels: [UILabel]!
    @IBOutlet var sportsBtns: [UIButton]!
    @IBOutlet var intensityBtns: [UIButton]!
    @IBOutlet var evaluBtns: [UIButton]!
    
    @IBOutlet weak var sportStackView: UIStackView!
    @IBOutlet weak var intensityStackView: UIStackView!
    @IBOutlet weak var evaluStackView: UIStackView!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabel()
        setButtonCollection(btns: sportsBtns, size: 14)
        setButtonCollection(btns: intensityBtns, size: 14)
        setButtonCollection(btns: evaluBtns, size: 12)
        setStackView()
        setDoneButton()
        setTextView()
        setToolBar()
        
        print(UIScreen.main.bounds.height)
        token = UserDefaults.standard.string(forKey: "token")
        //self.commentViewHeight.constant = 500*deviceHeight
        
        scrollView.delegate = self
        // 기기별 height길이
        scrollView.contentSize.height *= deviceHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotification()
    }
    
    // need to fix 안먹는다..! 왜지?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setLabel() {
        naviTitleLabel.font = UIFont.notoSansMedium(size: 18)
        naviTitleLabel.textColor = .black
        
        guideLabels.map {
            $0.font = UIFont.notoSansMedium(size: 18)
        }
    }
    
    func setStackView() {
        sportStackView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 0)
        intensityStackView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 0)
        evaluStackView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 0)
    }
    
    func setButtonCollection(btns: [UIButton], size: Int) {

        for idx in btns.indices {
            btns[idx].isSelected = false
            btns[idx].setBorderColorAndRadius(borderColor: grey, borderWidth: 0.5, cornerRadius: 0)
            btns[idx].tintColor = .lightGray
            btns[idx].backgroundColor = .white
            btns[idx].titleLabel?.font = UIFont.notoSansMedium(size: CGFloat(size))
            
        }
    }
    
    func setDoneButton() {
        
        doneButton.isEnabled = false
        doneButton.backgroundColor = .lightGray
        doneButton.titleLabel?.font = UIFont.notoSansMedium(size: 18)
        doneButton.titleLabel?.text = "기록하기"
        doneButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        doneButton.titleLabel?.textColor = .white
    }
    
    func doneButtonObserver() {
        
        if sportsBtnIdx != nil && intensityBtnIdx != nil && evaluBtnIdx != nil { // 각각 모두 선택되었을 때
            
            doneButton.activated()
            //return true
        } else {
            
            doneButton.deactivated()
            //return false
        }
    }
    
    func setTextView() {
        
        commentTextView.delegate = self
        
        commentTextView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 0)
        commentTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        commentTextView.font = UIFont.notoSansMedium(size: 14)
    }
    
    func setToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let toolbarSpacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let keyboardDoneBtn = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(keyboardDoneBtnClicked))
        keyboardDoneBtn.tintColor = UIColor(named: "OOD_purple")
        toolbar.items = [toolbarSpacing, keyboardDoneBtn]
        
        commentTextView.inputAccessoryView = toolbar
    }
                                             
    @objc func keyboardDoneBtnClicked() {
        self.view.endEditing(true)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func radioBtnClicked(_ sender: UIButton) {
        if sportsBtns.contains(sender) {
            radioBtn(sender: sender, btnType: .sport)
        } else if intensityBtns.contains(sender) {
            radioBtn(sender: sender, btnType: .intensity)
        } else if evaluBtns.contains(sender) {
            radioBtn(sender: sender, btnType: .evalu)
        }
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        
        let exComment = commentTextView.text ?? ""
        guard let userToken = token, let exTime = exerciseTime, let exIntensity = intensityBtns[intensityBtnIdx!].titleLabel?.text, let exEvalu = evaluBtns[evaluBtnIdx!].titleLabel?.text, let certiSport = sportsBtns[sportsBtnIdx!].titleLabel?.text else { return }
        
        // content upload 후 response 데이터의 certiId get, certiId 프로퍼티 옵저버 didset으로 이미지 업로드까지 실행
        uploadContent(userToken, exTime, exIntensity, exEvalu, exComment, certiSport)
    }
    
}

extension CertiSelectViewController {
    
    func uploadContent(_ token: String, _ exTime: String, _ exIntensity: String, _ exEvalu: String, _ exComment: String, _ certiSport: String) {
        
        var simpleResponse: SimpleResponse?
        
        APIService.shared.certiContentUpload(token: token, exTime: exTime, exIntensity: exIntensity, exEvalu: exEvalu, exComment: exComment, certiSport: certiSport) { result in

            switch result {
            case .success(let resultData):
                simpleResponse = resultData as? SimpleResponse
                self.certiId = simpleResponse?.data!
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func uploadImage(_ token: String, _ image: UIImage, _ certiId: Int) {
        
        APIService.shared.certiImageUpload(token: token, image: image, certiId: certiId) { result in
            
            switch result {
            case .success(_):
                self.navigationController?.popToRootViewController(animated: true)
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func radioBtn(sender: UIButton, btnType: ButtonCollectionType) {
        
        var btnIndex: Int? {
            didSet {
                switch btnType {
                case .sport:
                    sportsBtnIdx = btnIndex ?? nil
                case .intensity:
                    intensityBtnIdx = btnIndex ?? nil
                case .evalu:
                    evaluBtnIdx = btnIndex ?? nil
                }
            }
        }
        let btnCollection: [UIButton]?
        
        switch btnType {
        case .sport:
            btnIndex = sportsBtnIdx
            btnCollection = sportsBtns
        case .intensity:
            btnIndex = intensityBtnIdx
            btnCollection = intensityBtns
        case .evalu:
            btnIndex = evaluBtnIdx
            btnCollection = evaluBtns
        }
        
        if btnIndex == nil { // 타임스탬프 첫 선택
            sender.isSelected = true
            btnIndex = btnCollection!.firstIndex(of: sender)
            
            sender.tintColor = .white
            sender.backgroundColor = UIColor(named: "OOD_blue")
            
        } else { // 이미 하나 선택되어 있는 상태
            
            if sender.isSelected { // 선택되어 있는 것 다시 선택 == 취소
                
                sender.isSelected = false
                btnIndex = nil
                
                sender.tintColor = .lightGray
                sender.backgroundColor = .white
                
                
            } else { // 다른 타임스탬프 선택
                
                for idx in btnCollection!.indices {
                    btnCollection![idx].isSelected = false
                    
                    btnCollection![idx].tintColor = .lightGray
                    btnCollection![idx].backgroundColor = .white
                }
                
                sender.isSelected = true
                btnIndex = btnCollection!.firstIndex(of: sender)
                
                sender.tintColor = .white
                sender.backgroundColor = UIColor(named: "OOD_blue")
            }
        }
        doneButtonObserver()
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        
        if self.keyboardHeight == nil {
            if let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                UIView.animate(withDuration: 0.3, animations: {
                    self.keyboardHeight = keyboardFrame.cgRectValue.height
                    self.scrollView.contentOffset.y += (self.keyboardHeight! - self.commentViewHeight.constant*0.4)
                })
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.y += (self.keyboardHeight! - self.commentViewHeight.constant*0.4)
            })
        }
                           
     }
        
    @objc func keyboardWillHide(_ noti: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset.y -= (self.keyboardHeight! - self.commentViewHeight.constant*0.4)
        })
    }
    
}

extension CertiSelectViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
    }
}

extension CertiSelectViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
