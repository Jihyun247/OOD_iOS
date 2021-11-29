//
//  APIService.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation
import Moya
import SwiftUI

struct APIService {
    
    static let shared = APIService()
    
    let provider = MoyaProvider<APITarget>()
    
    //MARK: - AUTH API
    
    func login(_ email: String, _ password: String, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .signin(email: email, password: password)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
 
                guard let decodedData = try? JSONDecoder().decode(GenericResponse<LoginData>.self, from: response.data) else {
                    return completion(.pathErr)
                }

                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message ?? ""))
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

                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message ?? ""))
                }
                
                completion(.success(data))

            case .failure(let err):
                completion(.failure(err))
                
            }
        }
    }
    
    //MARK: - CERTIFICATION API
    
    func certiListByCal(token: String, date: String, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .certiByCal(token: token, date: date)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                guard let decodedData = try? JSONDecoder().decode(GenericResponse<[CertiListData]>.self, from: response.data) else {
                    return completion(.pathErr)
                }

                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message ?? ""))
                }
                
                completion(.success(data))

            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func certiListByCal(token: String, certiId: Int, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .certiDetail(token: token, certiId: certiId)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                guard let decodedData = try? JSONDecoder().decode(GenericResponse<CertiDetailData>.self, from: response.data) else {
                    return completion(.pathErr)
                }
    
                guard let data = decodedData.data else {
                    return completion(.requestErr(decodedData.message ?? ""))
                }
                
                completion(.success(data))

            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func certiDelete(token: String, certiId: Int, completion: @escaping (NetworkResult<Any>)->()) {
        
        let target: APITarget = .certiDelete(token: token, certiId: certiId)
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                if let decodedData = try? JSONDecoder().decode(SimpleResponse.self, from: response.data) {
                    completion(.success(decodedData))
                }

            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    
    
}

