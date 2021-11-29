//
//  CertiUploadViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import UIKit
import PhotosUI

class CertiUploadViewController: UIViewController {
    
    var timestampIndex: Int?
    var isTimestamped: Bool = false
    var isPhotoUploaded: Bool = false
    var uploadPhotoDate: Date? {
        didSet {
            
            if let date = uploadPhotoDate {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                timeStampLabel.text = dateFormatter.string(from: date)
            }
            
        }
    }
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: PaddingLabel!
    
    @IBOutlet weak var btnContainView: UIView!
    @IBOutlet weak var addPhotoIconView: UIImageView!
    @IBOutlet weak var speechBalloonImageView: UIImageView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    @IBOutlet var tsBtnViews: [UIView]!
    @IBOutlet var timestampRadioBtns: [UIButton]!
    @IBOutlet var tsBtnLabels: [UILabel]!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelUI()
        setViewUI()
        setButtonUI()
        
        picker.delegate = self

        // 다음버튼 비활성화 isTimestamped = false (타스 누르면 활성화)
        // 타임스탬프 비활성화 isPhotoUploaded = false (이미지 불러오면 활성화)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if isTimestamped == true {
            guard let certiTimeSelectVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiTimeSelectViewController") as? CertiTimeSelectViewController else {return}
            
            navigationController?.pushViewController(certiTimeSelectVC, animated: true)
            
        }
    }
    
    @IBAction func addPhotoBtnClicked(_ sender: UIButton) {
        let alert =  UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let camera =  UIAlertAction(title: "사진 앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func timestampBtnClicked(_ sender: UIButton) {
        if timestampIndex == nil { // 타임스탬프 첫 선택
            
            sender.isSelected = true
            timestampIndex = timestampRadioBtns.firstIndex(of: sender)
            
            tsBtnViews[timestampIndex!].backgroundColor = UIColor(named: "OOD_blue")
            tsBtnLabels[timestampIndex!].textColor = .white
            
            isTimestamped = true
            
        } else { // 이미 하나 선택되어 있는 상태
            
            if sender.isSelected { // 선택되어 있는 것 다시 선택 == 취소
                
                sender.isSelected = false
                tsBtnViews[timestampIndex!].backgroundColor = .white
                tsBtnLabels[timestampIndex!].textColor = .lightGray
                timestampIndex = nil
                
                isTimestamped = false
                
            } else { // 다른 타임스탬프 선택
                
                for idx in timestampRadioBtns.indices {
                    timestampRadioBtns[idx].isSelected = false
                    
                    tsBtnViews[idx].backgroundColor = .white
                    tsBtnLabels[idx].textColor = .lightGray
                }
                
                sender.isSelected = true
                timestampIndex = timestampRadioBtns.firstIndex(of: sender)
                
                tsBtnViews[timestampIndex!].backgroundColor = UIColor(named: "OOD_blue")
                tsBtnLabels[timestampIndex!].textColor = .white
                
                isTimestamped = true
                        
            }
        }
        
        if isTimestamped {
            nextButton.isEnabled = true
            nextButton.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        } else {
            nextButton.isEnabled = false
            let subLayer = nextButton.layer.sublayers!
            for idx in subLayer.indices {
                if (subLayer[idx] != subLayer.last) {
                    nextButton.layer.sublayers![idx].removeFromSuperlayer()
                }
            }
            nextButton.backgroundColor = .lightGray
        }
        
    }
    
    func setNavigationBar(date: String) {
        title = "오늘의 운동 기록하기"
        
        navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backbtn"), style: .plain, target: self, action: #selector(popButtonClicked))
    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

    func setLabelUI() {
        
        timeStampLabel.font = UIFont.robotoMedium(size: 32)
        // 패딩 줘야함
        
        for idx in tsBtnViews.indices {
            tsBtnLabels[idx].font = UIFont.robotoMedium(size: 14)
            tsBtnLabels[idx].textColor = .lightGray
        }
        
    }
    
    func setViewUI() {
        
        btnContainView.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
        imageContainView.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
        imageContainView.isHidden = true
        
        for idx in tsBtnViews.indices {
            tsBtnViews[idx].setBorderColorAndRadius(borderColor: .lightGray, borderWidth: 0.8, cornerRadius: 4)
            tsBtnViews[idx].backgroundColor = .white
        }
    
    }
    
    func setButtonUI() {
        nextButton.isEnabled = false
        nextButton.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
        
    }
    
}

extension CertiUploadViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.uploadedImageView.image = image
            self.imageContainView.isHidden = false
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
                
                // 찍은 시간만 가져오면 되는데, 굳이 이렇게 안해도
                print("카메라로 찍음")
                
            } else if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
                print(info)
                let exifDate = getExifDate(by: info)
                //timeStampLabel.text
                print(exifDate)
            }
        }
        
        
    }
    
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func getExifDate(by info: [UIImagePickerController.InfoKey : Any]) -> Date? {
        guard let url = info[.imageURL] as? NSURL else { return nil }
        guard let imageSource = CGImageSourceCreateWithURL(url, nil) else { return nil }
        // 와 대박 딕셔너리로 타입캐스팅
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary?
        let exifDict = imageProperties?[kCGImagePropertyExifDictionary]
        guard let dateTimeOriginal = exifDict?[kCGImagePropertyExifDateTimeOriginal] as? String else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        let exifDate = dateFormatter.date(from: dateTimeOriginal)
        print("호출")
        return exifDate
        
    }
}
