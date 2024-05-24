//
//  File.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

struct PlanOptionsResponseModel: Codable {
    let status: Int
    let message: String
    let data: PlanOptions
}

struct PlanOptions: Codable {
    let round: Int
    let minute: Int
    let condition: String
}
