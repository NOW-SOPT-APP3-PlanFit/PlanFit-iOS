//
//  WorkoutData.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/15/24.
//

import UIKit

struct WorkoutImageData: Hashable {
    let workoutImage: UIImage
}

struct SetVolume: Hashable {
    let weight: Int
    let repsNum: Int
    var currentSet: Bool
    var completedSet: Bool
    let uuid = UUID()
}

extension WorkoutImageData {
    static let list = [
        WorkoutImageData(workoutImage: UIImage(resource: .latpulldown))
    ]
}

extension SetVolume{
    static let list = [
        SetVolume(weight: 8, repsNum: 15, currentSet: true, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: true, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false),
        SetVolume(weight: 8, repsNum: 15, currentSet: false, completedSet: false)
    ]
}
