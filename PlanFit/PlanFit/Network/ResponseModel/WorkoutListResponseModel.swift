//
//  WorkoutListResponseModel.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

struct WorkoutListResponseModel: Codable {
    let status: Int
    let message: String
    let data: WorkoutList
}

struct WorkoutList: Codable {
    let exercises: [WorkoutListExercises]
}

struct WorkoutListExercises: Codable {
    let id: Int
    let name: String
    let set: Int
    let weight: Int
    let count: Int
    let index: Int
}
