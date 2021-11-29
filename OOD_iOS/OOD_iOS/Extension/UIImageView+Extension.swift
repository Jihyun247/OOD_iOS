//
//  UIImageView+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/28.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setKFImage(from urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString) { result in
            switch result {
            case .success(let response):
                if response.image != nil {
                    self.image = response.image
                } else {
                    self.kf.setImage(with: URL(string: urlString))
                }
            case .failure(let err):
                print(err.errorCode)
            }
        }
    }
}
