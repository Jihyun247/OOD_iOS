//
//  String+Extension.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/29.
//

import Foundation

extension String {
    func recordTime() -> String {
        // Date 스트링에서 시간만 추출하기
        var format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let tempDate = formatter.date(from: self) else {
            return ""
        }
        
        format = "HH:mm"
        formatter.dateFormat = format
        
        return formatter.string(from: tempDate)
    }
    
    func recordDate() -> String {
        // "yyyy-MM-dd HH:mm:ss"형식의 string 시간을 "yyyy년 MM월 dd일" 형식의 string time으로 바꾸기
        var format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let tempDate = formatter.date(from: self) else {
            return ""
        }
        
        format = "yyyy/MM/dd"
        formatter.dateFormat = format
        
        return formatter.string(from: tempDate)
    }
}
