//
//  UILabel+Class.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    
        private var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: padding))
        }
    
        convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
        }

        override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right

            return contentSize
        }
}
