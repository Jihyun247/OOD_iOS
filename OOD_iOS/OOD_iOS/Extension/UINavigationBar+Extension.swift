//
//  UINavigationBar+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/26.
//

import Foundation
import UIKit

extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
