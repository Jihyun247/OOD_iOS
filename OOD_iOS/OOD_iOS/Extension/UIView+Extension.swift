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
    
    func applyViewGradient(colors: [CGColor?]) {
        let gradientLayer = CAGradientLayer()
        let cArray: [CGColor] = colors.compactMap{$0}
        gradientLayer.colors = cArray
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func snapShot() -> UIImage {
        print("스냅샷")
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { context in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
