//
//  CertiCollectionReusableView.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/25.
//

import UIKit

protocol SelectedDateDelegate {
    func setLabel(date: String)
}

class CertiCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    static let identifier = "CertiCollectionReusableView"

}

extension CertiCollectionReusableView: SelectedDateDelegate {
    func setLabel(date: String) {
        print("얘가문제인가")
        selectedDateLabel.text = date
    }
    
}
