//
//  WorkoutListRequestModel.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

struct WorkoutListRequestModel: Codable {
    let exercises: [Exercises]
}

struct Exercises: Codable {
    let id: Int
    let index: Int
}
