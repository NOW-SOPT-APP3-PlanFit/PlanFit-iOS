//
//  WorkoutService.swift
//  PlanFit
//
//  Created by 왕정빈 on 5/23/24.
//

import Foundation

import Moya

final class WorkoutService {
    static let shared = WorkoutService()
    private var workoutProvider = MoyaProvider<WorkoutTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension WorkoutService {
    
    // MARK: - Home
    
    func getPlanOptions(completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.getPlanOptions) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: PlanOptionsResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    func changePlanOptions(request: PlanOptionsRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.changePlanOptions(request: request)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    // MARK: - WorkoutList
    
    func getWorkoutList(completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.getWorkoutList) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: WorkoutListResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    func changeWorkoutList(request: WorkoutListRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.changeWorkoutList(request: request)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    // MARK: - Workout
    
    func addSet(exerciseId: Int, completion: @escaping (NetworkResult<Any>) -> Void ) {
        workoutProvider.request(.addSet(exerciseId: exerciseId)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    func completeSet(exerciseId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.completeSet(exerciseId: exerciseId)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    func likeHeart(exerciseId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.likeHeart(exerciseId: exerciseId)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    func unlikeHeart(exerciseId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        workoutProvider.request(.unlikeHeart(exerciseId: exerciseId)) { [weak self] result in
            guard let self else { return }
            self.completionMethod(
                responseModel: GeneralResponseModel.self,
                result: result,
                completion: completion
            )
        }
    }
    
    // MARK: - Completion
    
    func completionMethod<T: Codable>(
        responseModel: T.Type,
        result: Result<Response, MoyaError>,
        completion: (NetworkResult<Any>) -> Void) {
        switch result {
        case .success(let response):
            let statusCode = response.statusCode
            let data = response.data
            
            let networkResult = self.judgeStatus(by: statusCode, data, T.self)
            completion(networkResult)
            
        case .failure:
            completion(.networkFail)
        }
    }
    
    // MARK: - Status Method
    
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)애서 디코딩 오류가 발생했습니다 ⛔️")
            return .decodedErr
        }
        return .success(decodedData as Any)
    }
}
