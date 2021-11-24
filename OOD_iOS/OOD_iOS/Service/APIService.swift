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
    
    func signup(_ nickname: String, _ email: String, _ password: String, _ exCycle: Int, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .signup(email: email, password: password, nickname: nickname, exCycle: exCycle)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):

                guard let decodedData = try? JSONDecoder().decode(GenericResponse<SignupData>.self, from: response.data) else {
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
