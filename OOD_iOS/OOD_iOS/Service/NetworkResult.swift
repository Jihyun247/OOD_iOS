//
//  NetworkResult.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
