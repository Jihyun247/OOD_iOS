//
//  CertiListData.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/27.
//

import Foundation

struct CertiListData: Codable {
    let id: Int
    let imageUrl: String?
    let createdAt: String?
    let userId: Int
    let userNickname: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
        case createdAt = "created_at"
        case userId = "user_id"
        case userNickname = "user_nickname"
    }
}
