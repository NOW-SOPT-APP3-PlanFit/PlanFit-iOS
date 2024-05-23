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
    static func dummy() -> [WorkoutListModel] {
        return [
            WorkoutListModel(
                name: "웜업 스트레칭",
                workoutImage: .stretching,
                caption: "6개의 스트레칭",
                arrowImage: .arrowDown,
                additionalInfo:
                    "싸이클\n로테이팅 허리 스트레칭\n후면 어깨 스트레칭\n어깨/등 스트레칭\n원 암 가슴 스트레칭\n크로스오버 힙/고관절 스트레칭"
            ),
            WorkoutListModel(
                name: "렛 풀다운",
                workoutImage: .latpulldown,
                caption: "4세트 X 8.0kg X 15회",
                arrowImage: .ellipsis,
                additionalInfo: nil
            ),
            WorkoutListModel(
                name: "체스트 프레스 머신",
                workoutImage: .chestpress,
                caption: "4세트 X 8.0kg X 15회",
                arrowImage: .ellipsis,
                additionalInfo: nil
            ),
            WorkoutListModel(
                name: "덤벨 레터럴 레이즈",
                workoutImage: .dumbellraise,
                caption: "4세트 X 1.0kg X 15회",
                arrowImage: .ellipsis,
                additionalInfo: nil
            ),
            WorkoutListModel(
                name: "덤벨 런치",
                workoutImage: .dumbelllunge,
                caption: "4세트 X 1.0kg X 15회",
                arrowImage: .ellipsis,
                additionalInfo: nil
            ),
            WorkoutListModel(
                name: "덤벨 바이셉 컬",
                workoutImage: .dumbellcurl,
                caption: "4세트 X 1.0kg X 15회",
                arrowImage: .ellipsis,
                additionalInfo: nil
            ),
            WorkoutListModel(
                name: "쿨다운 스트레칭",
                workoutImage: .stretching,
                caption: "4개의 스트레칭",
                arrowImage: .arrowDown,
                additionalInfo:
                    "후면 어깨 스트레칭\n오버헤드 등 스트레칭\n비하인드 암 가슴 스트레칭\n스탠딩 힙/고관절 스트레칭\n"
            )
        ]
    }
}
