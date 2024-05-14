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
    let weight: String
    let number: String
}

extension WorkoutImageData {
    static let list = [
        WorkoutImageData(workoutImage: UIImage(resource: .latpulldown))
    ]
}
