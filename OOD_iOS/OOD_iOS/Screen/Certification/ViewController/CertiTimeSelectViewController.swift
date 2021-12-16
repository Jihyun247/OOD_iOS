//
//  CertiTimeSelectViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import UIKit
import DropDown

class CertiTimeSelectViewController: UIViewController  {
    
    
    let grey = UIColor(red: 221/255, green: 225/255, blue: 229/255, alpha: 1)
    var timestampImage: UIImage?
    var exTime: String?
    let dropdown = DropDown()

    @IBOutlet weak var naviTitleLabel: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var timeGuideLabel: UILabel!
    @IBOutlet weak var selectTimeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dropdownArrowImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabel()
        setDropdownView()
        setNextButton()
        
        uploadedImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(snapImageUploaded(notification:)), name: NSNotification.Name("snapImageUploaded"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changedropBtn(notification:)), name: NSNotification.Name("changedropBtn"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("snapImageUploaded"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("changedropBtn"), object: nil)
    }
    
    @objc func snapImageUploaded(notification: NSNotification) {
        if let image = notification.userInfo?["snapImage"] as? UIImage {
            timestampImage = image
            uploadedImageView.image = image
            uploadedImageView.isHidden = false
            
            setNextBtnStatus()
        }
    }
    
    @objc func changedropBtn(notification: NSNotification) {
        dropdownArrowImageView.image = UIImage(named: "dropdown")
    }
    
    func setLabel() {
        naviTitleLabel.font = UIFont.notoSansMedium(size: 18)
        naviTitleLabel.textColor = .black
        
        timeGuideLabel.font = UIFont.notoSansMedium(size: 18)
        timeGuideLabel.textColor = .black
        
        selectTimeLabel.font = UIFont.notoSansMedium(size: 18)
        selectTimeLabel.textColor = .lightGray
    }
    
    func setDropdownView() {
        dropdownView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 4)
        
        dropdown.dataSource = ["20분", "30분", "40분", "50분", "1시간", "1시간 10분", "1시간 20분", "1시간 30분", "1시간 40분", "2시간", "2시간 20분", "2시간 40분", "3시간"]
        dropdown.anchorView = dropdownView
        dropdown.textFont = UIFont.notoSansMedium(size: 16)!
        dropdown.bottomOffset = CGPoint(x: 0, y: (dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.direction = .bottom
        dropdown.shadowOpacity = 0
        
        dropdownArrowImageView.image = UIImage(named: "dropdown")
        
        // 드롭다운 메뉴 선택 시
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            exTime = item
            selectTimeLabel.text = item
            self.dropdown.clearSelection()
            
            setNextBtnStatus()
        }
    }
    
    func setNextButton() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightGray
        nextButton.titleLabel?.font = UIFont.notoSansMedium(size: 18)
        nextButton.titleLabel?.text = "다음"
        nextButton.setBorderColorAndRadius(borderColor: nil, borderWidth: 0, cornerRadius: 8.0)
        nextButton.titleLabel?.textColor = .white
    }
    
    func setNextBtnStatus() {
        if timestampImage != nil && exTime != nil { // 각각 모두 선택되었을 때
            nextButton.activated()
        } else {
            nextButton.deactivated()
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        guard let certiSelectVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiSelectViewController") as? CertiSelectViewController else {return}
        certiSelectVC.timestampImage = self.timestampImage
        certiSelectVC.exerciseTime = self.exTime
        navigationController?.pushViewController(certiSelectVC, animated: true)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // 카메라 NVC로 이동
    @IBAction func addImageBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Camera", bundle: nil)
        guard let cameraNVC = sb.instantiateViewController(identifier: "CameraNavigationViewController") as? CameraNavigationViewController else { return }
        cameraNVC.modalPresentationStyle = .fullScreen
        present(cameraNVC, animated: true, completion: nil)
    }
    
    @IBAction func dropdownBtnClicked(_ sender: UIButton) {
        dropdown.show()
        dropdown.show(onTopOf: dropdown.window, beforeTransform: CGAffineTransform(scaleX: 1.0, y: 1.0), anchorPoint: CGPoint(x: 0, y: (dropdown.anchorView?.plainView.bounds.height)!))
        dropdownArrowImageView.image = UIImage(named: "dropup")
    }

}
