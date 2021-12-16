//
//  MypageViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit

class MypageViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNicknameLabel: UILabel!
    
    @IBOutlet var defaultLabelCollection: [UILabel]!
    @IBOutlet weak var achivementLabel: UILabel!
    @IBOutlet weak var recordNumLabel: UILabel!
    
    @IBOutlet weak var btnBackView: UIView!
    @IBOutlet weak var exCycleUpdateBtn: UIButton!
    
    @IBOutlet weak var certiCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabel()
        setButton()
        
        certiCollectionView.delegate = self
        certiCollectionView.dataSource = self
    }
    
    func setLabel() {
        
    }
    
    func setButton() {
        
    }

}

extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
}
