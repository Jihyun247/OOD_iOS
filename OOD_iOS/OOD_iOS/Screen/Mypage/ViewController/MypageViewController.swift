//
//  MypageViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit

class MypageViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var myInfoBackView: UIView!
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNicknameLabel: UILabel!
    
    @IBOutlet var defaultLabelCollection: [UILabel]!
    @IBOutlet weak var achivementLabel: UILabel!
    @IBOutlet weak var recordNumLabel: UILabel!
    
    @IBOutlet weak var exCycleUpdateBtnBackView: UIView!
    @IBOutlet weak var exCycleUpdateBtn: UIButton!
    
    @IBOutlet weak var certiCollectionView: UICollectionView!
    
    var certiListData: [CertiListData] = [] {
        didSet {
            print("didset",certiListData)
            certiCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabel()
        setButton()
        setUiView()
        setCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            print("viewWillAppear 컬렉션 뷰 서버통신")
            mypageAllCertiList(token: token)
        }
    }
    
    func mypageAllCertiList(token: String) {
        APIService.shared.mypageAllCertiList(token: token) { result in
            switch result {
            case .success(let resultData):
                self.certiListData = resultData as? [CertiListData] ?? []
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func setLabel() {
        
    }
    
    func setButton() {
        exCycleUpdateBtn.applyViewGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
        exCycleUpdateBtn.makeCircleCorner(frameHeight: exCycleUpdateBtn.frame.height)
    }
    
    func setUiView() {
        myInfoBackView.applyViewGradient(colors: [UIColor(named: "OOD_blue")?.cgColor, UIColor(named: "OOD_purple")?.cgColor])
    }
    
    func setCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        certiCollectionView.collectionViewLayout = layout
        
        certiCollectionView.delegate = self
        certiCollectionView.dataSource = self
        
        let nibName = UINib(nibName: CertiCollectionViewCell.identifier, bundle: nil)
        certiCollectionView.register(nibName, forCellWithReuseIdentifier: CertiCollectionViewCell.identifier)
    }
    
    @IBAction func settingBtnClicked(_ sender: UIButton) {
        
    }
    

}

extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 셀 개수 & 셀 내용
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certiListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = certiCollectionView.dequeueReusableCell(withReuseIdentifier: "CertiCollectionViewCell", for: indexPath) as? CertiCollectionViewCell else { return UICollectionViewCell() }
        print("cell설정 delegate")
        cell.certiImageView.setKFImage(from: certiListData[indexPath.row].imageUrl ?? "")
        cell.certiImageView.contentMode = .scaleAspectFill
        cell.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
        
        return cell
    }
    
    // 셀 클릭 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let certiDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiDetailViewController") as? CertiDetailViewController else { return}
        
        certiDetailVC.certiId = certiListData[indexPath.row].id
        navigationController?.pushViewController(certiDetailVC, animated: true)
    }
}

//extension MypageViewController: UICollectionViewLayoutAttributes {
//
//}
