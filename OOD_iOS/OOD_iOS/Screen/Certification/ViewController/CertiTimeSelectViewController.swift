//
//  CertiTimeSelectViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import UIKit

protocol SnapUploadDelegate {
    func uploadSnap(image: UIImage)
}

class CertiTimeSelectViewController: UIViewController, SnapUploadDelegate  {
    
    func uploadSnap(image: UIImage) {
        if let image = uploadedImage {
            uploadedImageView.image = image
            uploadedImageView.isHidden = false
        }
    }
    
    
    var uploadedImage: UIImage?
    
    @IBOutlet weak var uploadedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadedImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = uploadedImage {
            uploadedImageView.image = image
            uploadedImageView.isHidden = false
        }
        
        print(uploadedImage)
        
        
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        guard let certiSelectVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiSelectViewController") as? CertiSelectViewController else {return}
        
        navigationController?.pushViewController(certiSelectVC, animated: true)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageBtnClicked(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Camera", bundle: nil)
        guard let cameraNaviVC = sb.instantiateViewController(identifier: "CameraNavigationViewController") as? CameraNavigationViewController else { return }
        cameraNaviVC.modalPresentationStyle = .fullScreen
        present(cameraNaviVC, animated: true, completion: nil)
    }
    
    
    

}
