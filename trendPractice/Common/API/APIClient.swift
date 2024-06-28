//
//  APIClient.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire


class APIClient {
    typealias completionHandler<T> = (T?, AFError?) -> Void
    
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
                    completionHandler(nil, error)
                }
            }
    }
}
