//
//  CertiDetailViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/27.
//

import UIKit

class CertiDetailViewController: UIViewController {
    
    let deviceHeight = UIScreen.main.bounds.height / 896
    var token: String?
    var certiId: Int?
    var certiDetailData: CertiDetailData? {
        didSet {
            if let detailData = self.certiDetailData, let certi = detailData.certi {
                setNavigationBar(date: certi.parseDate)
                setLabel(certi: certi)
                setImageView(imageUrl: certi.certiImage ?? "")
            }
        }
    }
    
    @IBOutlet weak var certiImageView: UIImageView!
    @IBOutlet weak var imageContainViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var exTimeGuideLabel: UILabel!
    @IBOutlet weak var certiSportGuideLabel: UILabel!
    @IBOutlet weak var exIntensityGuideLabel: UILabel!
    @IBOutlet weak var exEvaluGuideLabel: UILabel!
    @IBOutlet weak var exCommentGuideLabel: UILabel!
    
    @IBOutlet weak var exTimeLabel: PaddingLabel!
    @IBOutlet weak var certiSportLabel: PaddingLabel!
    @IBOutlet weak var exIntensityLabel: PaddingLabel!
    @IBOutlet weak var exEvaluLabel: PaddingLabel!
    @IBOutlet weak var exCommentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = UserDefaults.standard.string(forKey: "token")
        certiDetail(token: token!, id: certiId!)
        
        setTextView()
        
//        let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjM3NzM0NzY3LCJleHAiOjE2NjM2NTQ3NjcsImlzcyI6Im9vZCJ9.YDDrwpfOUMWggJnfNJFcPs7TVeLp7rw_hLorlr5FzVs"
//        certiDetail(token: token, id: certiId!)
    }
    
    func certiDetail(token: String, id: Int) {
        APIService.shared.certiListByCal(token: token, certiId: certiId!) { result in
            switch result {
            case .success(let resultData):
                self.certiDetailData = resultData as? CertiDetailData
            case .requestErr(let message):
                print("requestErr")
                print(message)
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func setLabel(certi: Certi) {
        
        exTimeGuideLabel.font = UIFont.notoSansMedium(size: 18)
        certiSportGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exIntensityGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exEvaluGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exCommentGuideLabel.font = UIFont.notoSansMedium(size: 18)
        
        let OOD_purple = UIColor(named: "OOD_purple")
        
        exTimeLabel.text = certi.exTime
        exTimeLabel.setBorderColorAndRadius(borderColor: OOD_purple, borderWidth: 1, cornerRadius: 2)
        exTimeLabel.font = UIFont.notoSansMedium(size: 16)
        
        certiSportLabel.text = certi.certiSport
        certiSportLabel.setBorderColorAndRadius(borderColor: OOD_purple, borderWidth: 1, cornerRadius: 2)
        certiSportLabel.font = UIFont.notoSansMedium(size: 16)
        
        exIntensityLabel.text = certi.exIntensity
        exIntensityLabel.setBorderColorAndRadius(borderColor: OOD_purple, borderWidth: 1, cornerRadius: 2)
        exIntensityLabel.font = UIFont.notoSansMedium(size: 16)
        
        exEvaluLabel.text = certi.exEvalu
        exEvaluLabel.setBorderColorAndRadius(borderColor: OOD_purple, borderWidth: 1, cornerRadius: 2)
        exEvaluLabel.font = UIFont.notoSansMedium(size: 16)
        
        exCommentTextView.text = certi.exComment
        exCommentTextView.font = UIFont.notoSansMedium(size: 16)
    }
    
    func setTextView() {
        
        exCommentTextView.layer.borderColor = UIColor.lightGray.cgColor
        exCommentTextView.layer.borderWidth = 0.5
        exCommentTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
    func setImageView(imageUrl: String) {
        
        imageContainViewHeight.constant = deviceHeight * 400
        
        certiImageView.setKFImage(from: imageUrl)
        certiImageView.contentMode = .scaleAspectFill
        certiImageView.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
    }
    
    func setNavigationBar(date: String) {
        title = date
        
        navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backbtn"), style: .plain, target: self, action: #selector(popButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonClicked() {
        
        if let t = self.token, let c = self.certiId {
            APIService.shared.certiDelete(token: t, certiId: c) { result in
                switch result {
                case .success(_):
                    print("delete success")
                case .requestErr(let message):
                    print("requestErr")
                    print(message)
                case .pathErr:
                    print("pathErr")
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    
}
