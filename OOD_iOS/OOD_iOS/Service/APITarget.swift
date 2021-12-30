//
//  APITarget.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import Moya
import UIKit

enum APITarget { // 토큰 쿼리 파라미터 바디 모두 입력
    case signup(email: String, password: String, nickname: String, exCycle: Int)
    case signin(email: String, password: String)
    case certiContentUpload(token: String, exTime: String, exIntensity: String, exEvalu: String, exComment: String, certiSport: String)
    case certiImageUpload(token: String, image: UIImage, certiId: Int)
    case certiByCal(token: String, date: String)
    case certiDetail(token: String, certiId: Int)
    case certiUpdate(token: String, exTime: String, exIntensity: String, exEvalu: String, exComment: String, certiSport: String, certiId: Int)
    case certiDelete(token: String, certiId: Int)
    case mypageAllCertiList(token: String)
    case mypageInfo(token: String)
    case settingExCycle(token: String, exCycle: Int)
}

extension APITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://15.164.186.213:3000")!
    }
    
    var path: String { // path에 들어갈 파라미터 넣어주기
        switch self {
        case .signup:
            return "/user/signup"
        case .signin:
            return "/user/signin"
        case .certiContentUpload:
            return "/certi"
        case .certiImageUpload(_, _, let certiId):
            return "/certi/image/\(certiId)"
        case .certiByCal:
            return "/certi"
        case .certiDetail(_, let certiId):
            return "/certi/detail/\(certiId)"
        case .certiUpdate:
            return "/certi"
        case .certiDelete(_, let certiId):
            return "/certi/\(certiId)"
        case .mypageAllCertiList:
            return "/mypage"
        case .mypageInfo:
            return "/mypage/info"
        case .settingExCycle:
            return "/mypage/cycle"
        }
    }
    
    var method: Moya.Method { // 각 CRUD
        switch self {
        case .signup, .signin, .certiContentUpload, .certiImageUpload:
            return .post
        case .certiByCal, .certiDetail, .mypageAllCertiList, .mypageInfo:
            return .get
        case .certiUpdate, .settingExCycle:
            return .put
        case .certiDelete:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task { // 바디는 JSONEncoding.default, 쿼리가 들어가면 URLEncoding.queryString, 이미지는 .uploadMultipart
        switch self {
        case .certiDetail, .mypageAllCertiList, .mypageInfo, .certiDelete:
            return .requestPlain
        case .certiByCal(_, let date): // 쿼리
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .signup(let email, let password, let nickname, let exCycle):
            return .requestParameters(parameters: ["email": email, "password": password, "nickname": nickname, "ex_cycle": exCycle], encoding: JSONEncoding.default)
        case .signin(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .certiContentUpload(_, let exTime, let exIntensity, let exEvalu, let exComment, let certiSport):
            return .requestParameters(parameters: ["ex_time": exTime, "ex_intensity": exIntensity, "ex_evalu": exEvalu, "ex_comment": exComment, "certi_sport": certiSport], encoding: JSONEncoding.default)
        case .certiImageUpload(_, let image, _):
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0)!), name: "image", fileName: "jpeg", mimeType: "image/jpeg")
            return .uploadMultipart([imageData])
        case .certiUpdate(_, let exTime, let exIntensity, let exEvalu, let exComment, let certiSport, _):
            return .requestParameters(parameters: ["ex_time": exTime, "ex_intensity": exIntensity, "ex_evalu": exEvalu, "ex_comment": exComment, "certi_sport": certiSport], encoding: JSONEncoding.default)
        case .settingExCycle(_, let exCycle):
            return .requestParameters(parameters: ["ex_cycle": exCycle], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signup, .signin:
            return ["Content-Type": "application/json"]
        case .certiImageUpload(let token, _, _):
            return ["Content-Type": "multipart/form-data", "token": token]
        case .certiContentUpload(let token, _,_,_,_,_), .certiByCal(let token, _), .certiDetail(let token, _), .certiUpdate(let token, _,_,_,_,_,_), .certiDelete(let token, _), .mypageAllCertiList(let token), .mypageInfo(let token), .settingExCycle(let token, _):
            return ["Content-Type" : "application/json", "token" : token]
        }
    }
    
    
}
