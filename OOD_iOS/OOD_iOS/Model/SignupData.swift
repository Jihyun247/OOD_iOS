//
//  SignupData.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/25.
//

import Foundation

struct SignupData: Codable {
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
    }
}
