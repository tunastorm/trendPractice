//
//  APIClient.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire


class APIClient {
    typealias onSuccess<T> = ((T) -> Void)
    typealias onFailure = ((_ error: AFError) -> Void)
    
    static func request<T>(_ object: T.Type,
                           router: APIRouter,
                           success: @escaping onSuccess<T>,
                           failure: @escaping onFailure) where T:
    Decodable {
        print(#function, router)
        AF.request(router)
            .validate(statusCode: 200..<600)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodedData = response.value else {return}
                    dump(decodedData)
                    success(decodedData)
                case .failure(let error):
                    dump(error)
                    failure(error)
                }
            }
    }
}
