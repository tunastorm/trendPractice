//
//  APIClient.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire


class APIClient {
    typealias completionHandler<T> = (T?, APIError?) -> Void
    
    static func request<T>(_ object: T.Type,
                           router: APIRouter,
                           completionHandler: @escaping completionHandler<T>) where T:
    Decodable {
        print(#function, router)
        AF.request(router)
            .validate(statusCode: 200..<600)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodedData = response.value else {return}
//                    dump(decodedData)
                    completionHandler(decodedData, nil)
                case .failure(let error):
                    dump(error)
                    guard let errorCode = error.responseCode else {
                        let apiError = convertAFError(error: error)
                        completionHandler(nil, apiError)
                        return
                    }
                    let apiError = convertResponseStatus(errorCode: errorCode)
                    completionHandler(nil, apiError)
                }
            }
    }
    
    private static func convertAFError(error: AFError) -> APIError {
        var apiError: APIError
        switch error {
        case .sessionDeinitialized:
            apiError = APIError.networkError
        case .sessionInvalidated(let error):
            apiError = APIError.networkError
        case .sessionTaskFailed(let error):
            apiError = APIError.networkError
        case .responseSerializationFailed:
            apiError = APIError.noResultError
        default: apiError = APIError.unExpectedError
        }
        return apiError
    }
    
    private static func convertResponseStatus(errorCode: Int) -> APIError {
        var apiError = APIError.noResultError
        switch errorCode {
        case 300 ..< 400:
            apiError = APIError.redirectError
        case 400 ..< 500:
            apiError = APIError.clientError
        case 500 ..< 600:
            apiError = APIError.serverError
        default: APIError.networkError
        }
        return apiError
    }
      
}
