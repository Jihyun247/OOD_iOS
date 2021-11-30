//
//  UIButton+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import UIKit

extension UIButton {
    func applyGradient(colors: [CGColor?]) {
        let gradientLayer = CAGradientLayer()
        let cArray: [CGColor] = colors.compactMap{$0}
        gradientLayer.colors = cArray
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 긴 바 버튼 활성화/비활성화
    func activated() {
        self.isEnabled = true
        
        self.applyGradient(colors: [UIColor(named: "OOD_purple")?.cgColor, UIColor(named: "OOD_blue")?.cgColor])
    }
    
    func deactivated() {
        self.isEnabled = false
        
        let subLayer = self.layer.sublayers!
        for idx in subLayer.indices {
            if (subLayer[idx] != subLayer.last) {
                self.layer.sublayers![idx].removeFromSuperlayer()
            }
        }
        self.backgroundColor = .lightGray
    }
}
