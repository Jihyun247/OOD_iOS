//
//  UIView+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import UIKit

extension UIView {
    func setBorderColorAndRadius(borderColor: UIColor?, borderWidth: CGFloat, cornerRadius: CGFloat) {
        if let bColor = borderColor {self.layer.borderColor = bColor.cgColor}
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
//    func setCornerRadius(cornerRadius: CGFloat) {
//        self.
//    }
}
