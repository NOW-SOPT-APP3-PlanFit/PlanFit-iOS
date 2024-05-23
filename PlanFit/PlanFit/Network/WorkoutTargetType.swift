//
//  WorkoutTargetType.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

import Moya

enum WorkoutTargetType {
    case getPlanOptions
    case changePlanOptions(request: PlanOptionsRequestModel)
    case getWorkoutList
    case changeWorkoutList(request: WorkoutListRequestModel)
    case addSet(exerciseId: Int)
    case completeSet(exerciseId: Int)
    case likeHeart(exerciseId: Int)
    case unlikeHeart(exerciseId: Int)
}

extension WorkoutTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPlanOptions, .changePlanOptions:
            return "/api/v1/main"
        case .getWorkoutList, .changeWorkoutList:
            return "/api/v1/exercises"
        case .addSet(let exerciseId), .completeSet(let exerciseId):
            return "/api/v1/exercises/\(exerciseId)/set"
        case .likeHeart(let exerciseId):
            return "/api/v1/exercises/\(exerciseId)/like"
        case .unlikeHeart(let exerciseId):
            return "/api/v1/exercises/\(exerciseId)/unlike"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPlanOptions, .getWorkoutList:
            return .get
        case .changePlanOptions, .changeWorkoutList, .completeSet:
            return .put
        case .addSet:
            return .post
        case .likeHeart, .unlikeHeart:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPlanOptions,
                .getWorkoutList,
                .addSet,
                .completeSet,
                .likeHeart,
                .unlikeHeart:
            return .requestPlain
        case .changePlanOptions(let request):
            return .requestJSONEncodable(request)
        case .changeWorkoutList(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPlanOptions,
                .changePlanOptions,
                .getWorkoutList,
                .changeWorkoutList,
                .addSet, .completeSet,
                .likeHeart,
                .unlikeHeart:
            return ["Content-Type": "application/json",
                    "user_id" : "1"]
        }
    }
}
