//
//  TimeStampCheckViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/29.
//

import UIKit

class TimeStampCheckViewController: UIViewController {
    
    var snapImage:UIImage?
    var snapTime: String?
    var snapDate: String?
    
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var timestampBorderView: UIView!
    @IBOutlet weak var stampDateLabel: UILabel!
    @IBOutlet weak var stampTimeLabel: UILabel!
    
    @IBOutlet weak var resnapButton: UIButton!
    @IBOutlet weak var usePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCameraView()

        // Do any additional setup after loading the view.
    }
    
    func setCameraView() {
        
        snapImageView.image = snapImage
        
        stampDateLabel.font = UIFont.robotoMedium(size: 50)
        stampDateLabel.textColor = .white
        stampTimeLabel.font = UIFont.robotoMedium(size: 50)
        stampTimeLabel.textColor = .white
        if let date = snapDate, let time = snapTime {
            stampDateLabel.text = date
            stampTimeLabel.text = time
        }
        
        timestampBorderView.backgroundColor = .clear
        timestampBorderView.setBorderColorAndRadius(borderColor: .white, borderWidth: 1, cornerRadius: 2)
        
        resnapButton.titleLabel?.font = UIFont.notoSansMedium(size: 17)
        resnapButton.tintColor = UIColor(named: "OOD_purple")
        usePhotoButton.titleLabel?.font = UIFont.notoSansMedium(size: 17)
        usePhotoButton.tintColor = UIColor(named: "OOD_purple")
        
    }
    
    @IBAction func resnapBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func useBtnClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("snapImageUploaded"), object: nil, userInfo: ["snapImage": self.captureView.snapShot()])
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
