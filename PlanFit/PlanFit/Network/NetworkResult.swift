//
//  NetworkResult.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)              
    case requestErr
    case decodedErr
    case pathErr
    case serverErr
    case networkFail
}
