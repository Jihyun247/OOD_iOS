//
//  Date+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/29.
//

import Foundation

extension Date {
    func timestampToString() -> String {
        let formatter = DateFormatter()
        let format = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        
        return dateString
    }
}
