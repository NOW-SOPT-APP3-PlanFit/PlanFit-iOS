//
//  WorkoutTimeModel.swift
//  PlanFit
//
//  Created by 김진웅 on 5/21/24.
//

import Foundation

enum WorkoutTimeModel: CaseIterable {
    case short
    case littleShort
    case normal
    case littleLong
    case long
    case veryLong
}

extension WorkoutTimeModel {
    var title: String {
        switch self {
        case .short: "짧게"
        case .littleShort: "조금 짧게"
        case .normal: "보통"
        case .littleLong: "조금 길게"
        case .long: "길게"
        case .veryLong: "아주 길게"
        }
    }
    
    var description: String {
        switch self {
        case .short: "약 29분"
        case .littleShort: "약 44분"
        case .normal: "약 58분"
        case .littleLong: "약 73분"
        case .long: "약 87분"
        case .veryLong: "약 116분"
        }
    }
    
    var timeValue: Int {
        switch self {
        case .short: 29
        case .littleShort: 44
        case .normal: 58
        case .littleLong: 73
        case .long: 87
        case .veryLong: 116
        }
    }
}

extension WorkoutTimeModel {
    static func convert(from minute: Int) -> WorkoutTimeModel {
        switch minute {
        case 29: .short
        case 44: .littleShort
        case 58: .normal
        case 73: .littleLong
        case 87: .long
        case 116: .veryLong
        default: .normal
        }
    }
}
