//
//  CertiDetailViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/27.
//

import UIKit

class CertiDetailViewController: UIViewController {
    
    let grey = UIColor(red: 221/255, green: 225/255, blue: 229/255, alpha: 1)
    
    let deviceHeight = UIScreen.main.bounds.height / 896
    var token: String?
    var certiId: Int?
    var certiDetailData: CertiDetailData? {
        didSet {
            if let detailData = self.certiDetailData, let certi = detailData.certi {
                setLabel(certi: certi)
                setImageView(imageUrl: certi.certiImage ?? "")
            }
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    // 추후 드롭다운으로 수정 예정
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var naviTitleLabel: UILabel!
    
    
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
        print(UIScreen.main.bounds.height)
        token = UserDefaults.standard.string(forKey: "token")
        certiDetail(token: token!, id: certiId!)
        
        setTextView()
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
        
        // need to fix 레이블 컬렉션으로 다 바꾸기
        naviTitleLabel.font = UIFont.notoSansMedium(size: 18)
        exTimeGuideLabel.font = UIFont.notoSansMedium(size: 18)
        certiSportGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exIntensityGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exEvaluGuideLabel.font = UIFont.notoSansMedium(size: 18)
        exCommentGuideLabel.font = UIFont.notoSansMedium(size: 18)
        
        let OOD_purple = UIColor(named: "OOD_purple")
        
        naviTitleLabel.text = certi.parseDate
        naviTitleLabel.font = UIFont.notoSansMedium(size: 18)
        
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
        
        exCommentTextView.setBorderColorAndRadius(borderColor: grey, borderWidth: 1, cornerRadius: 0)
        exCommentTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        exCommentTextView.font = UIFont.notoSansMedium(size: 16)
        exCommentTextView.isEditable = false
    }
    func setImageView(imageUrl: String) {
        
        imageContainViewHeight.constant = deviceHeight * 400
        
        certiImageView.setKFImage(from: imageUrl)
        certiImageView.contentMode = .scaleAspectFill
        certiImageView.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
    }
    
    func deleteCerti() {
        if let t = self.token, let c = self.certiId {
            APIService.shared.certiDelete(token: t, certiId: c) { result in
                switch result {
                case .success(_):
                    print("delete success")
                    self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "잠깐!", message: "해당 게시물을 삭제하시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "확인", style: .default) { action in
            self.deleteCerti()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
