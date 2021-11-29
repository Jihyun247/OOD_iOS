//
//  CertiDetailData.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/27.
//

import Foundation

struct CertiDetailData: Codable {
    let user: User?
    let certi: Certi?
    
    enum CodingKeys: String, CodingKey {
        case user, certi
    }
}

struct User: Codable {
    let id: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case id, nickname
    }
}

struct Certi: Codable {
    let exTime: String
    let certiSport: String
    let exIntensity: String
    let exEvalu: String
    let exComment: String
    let parseDate: String
    let certiImage: String?
    
    enum CodingKeys: String, CodingKey {
        case exTime = "ex_time"
        case certiSport = "certi_sport"
        case exIntensity = "ex_intensity"
        case exEvalu = "ex_evalu"
        case exComment = "ex_comment"
        case parseDate = "parse_date"
        case certiImage = "certi_images"
    }
}
