//
//  APIService.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import Moya

struct APIService {
    
    static let shared = APIService()
    
    let provider = MoyaProvider<APITarget>()
    
    
}
