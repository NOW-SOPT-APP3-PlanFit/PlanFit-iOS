//
//  WorkoutListModel.swift
//  PlanFit
//
//  Created by 예삐 on 5/15/24.
//

import UIKit

struct WorkoutListModel {
    let name: String
    let workoutImage: UIImage
    let caption: String
    let arrowImage: UIImage
    let additionalInfo: String?
}

extension WorkoutListModel {
    static func createDummy(for kind: DummyKind) -> WorkoutListModel {
        return kind.dummy
    }
}

extension WorkoutListModel {
    enum DummyKind {
        case warmup
        case cooldown
        
        var dummy: WorkoutListModel {
            switch self {
            case .warmup:
                WorkoutListModel(
                    name: "웜업 스트레칭",
                    workoutImage: .stretching,
                    caption: "6개의 스트레칭",
                    arrowImage: .arrowDown,
                    additionalInfo:
                        "싸이클\n로테이팅 허리 스트레칭\n후면 어깨 스트레칭\n어깨/등 스트레칭\n원 암 가슴 스트레칭\n크로스오버 힙/고관절 스트레칭"
                )
                
            case .cooldown:
                WorkoutListModel(
                    name: "쿨다운 스트레칭",
                    workoutImage: .stretching,
                    caption: "4개의 스트레칭",
                    arrowImage: .arrowDown,
                    additionalInfo:
                        "후면 어깨 스트레칭\n오버헤드 등 스트레칭\n비하인드 암 가슴 스트레칭\n스탠딩 힙/고관절 스트레칭\n"
                )
            }
        }
    }
}
