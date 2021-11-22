//
//  UIFont+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import UIKit

extension UIFont {
    
    class func rubikRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Rubik-Regular", size: size)
    }
    
    class func robotoMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size)
    }
    
    class func notoSansMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansKR-Medium", size: size)
    }
    
    class func notoSansBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansKR-Bold", size: size)
    }
}
