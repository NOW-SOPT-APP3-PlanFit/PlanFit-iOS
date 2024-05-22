//
//  BodyConditionModel.swift
//  PlanFit
//
//  Created by 김진웅 on 5/21/24.
//

import Foundation

enum BodyConditionModel: CaseIterable {
    case better, normal, heavy, tired, bad
}

extension BodyConditionModel {
    var title: String {
        switch self {
        case .better: "125%"
        case .normal: "100%"
        case .heavy: "75%"
        case .tired: "50%"
        case .bad: "25%"
        }
    }
    
    var description: String {
        switch self {
        case .better: "컨디션이 평소보다 훨씬 좋습니다."
        case .normal: "평소와 같은 상태입니다."
        case .heavy: "몸이 무겁게 느껴집니다."
        case .tired: "피곤하고 기운이 없습니다."
        case .bad: "몸 상태가 매우 좋지 않습니다."
        }
    }
    
    var value: String {
        switch self {
        case .better: "최상"
        case .normal: "보통"
        case .heavy: "무거움"
        case .tired: "피곤함"
        case .bad: "나쁨"
        }
    }
}
