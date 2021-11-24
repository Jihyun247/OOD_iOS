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
    
    func login(_ email: String, _ password: String, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .signin(email: email, password: password)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                // JSONDecoder 포스팅 + 서버 모델 정리 + 로그인 서버통신 및 뷰 연결 마무리하기
                guard let decodedData = try? JSONDecoder().decode(GenericResponse<LoginData>.self, from: response.data) else {
                    return completion(.pathErr)
                }
                print(decodedData)
                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message))
                }
                
                completion(.success(data))

            case .failure(let err):
                completion(.failure(err))
                
            }
        }
        
    }
    
    
}
