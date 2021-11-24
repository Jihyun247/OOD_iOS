//
//  NetworkResult.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(T)
    case pathErr
    case requestErr(T)
    // moya 테스트 해보니 .success 또는 .failure가 뜸
}
