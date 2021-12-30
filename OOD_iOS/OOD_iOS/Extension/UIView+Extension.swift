//
//  UIView+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import UIKit

extension UIView {
    
    enum ViewSide {
    case Left, Right, Top, Bottom
        }
    
    func setBorderCustom(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
    let border = CALayer()
            border.backgroundColor = color
    switch side {
    case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
    case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
    case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
    case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
            }
            layer.addSublayer(border)
        }
    
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
    
    func makeCircleCorner(frameHeight: CGFloat) {
        self.layer.cornerRadius = frameHeight / 2
        self.layer.masksToBounds = true
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
