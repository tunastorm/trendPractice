//
//  APIRouter.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation

import Alamofire

enum APIConstants {

    static let token = ""
    static let includeImageLanguage = "en, jp"
    
    enum HTTPHeaderField {
        static let authentication = "Authorization"
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
        static let acceptEncoding = "Accept-Encoding"
        static let xAuthToken = "x-auth-token"
    }

    enum ResponseType {
        static let json = "application/json"
    }
    
    enum ContentsType {
        case movie
        case tv
    }
}


enum APIRouter: URLRequestConvertible {
 
    // MARK: Request Types
    case similerAPI(contentsType: APIConstants.ContentsType, contentsId: Int, page: Int)
    case recommendationsAPI(contentsType: APIConstants.ContentsType, contentsId: Int, page: Int)
    case imagesAPI(contentsType: APIConstants.ContentsType, contentsId: Int, includeImageLanguage: String)
 

    
    // MARK: Methods
    var method: HTTPMethod {
        switch self {
        case .similerAPI(let contentsType, let contentsId, let page),
             .recommendationsAPI(let contentsType, let contentsId, let page):
            return .get
        case .imagesAPI(let contentsType, let contentsId, let includeImageLanguage):
            return .get
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case  .similerAPI(let contentsType, let contentsId, let page):
            return "\(contentsType)/\(contentsId)/similar"
        case .recommendationsAPI(let contentsType, let contentsId, let page):
            return "\(contentsType)/\(contentsId)/recommendations"
        case .imagesAPI(let contentsType, let contentsId, let includeImageLanguage):
            return "\(contentsType)/\(contentsId)/images"
        }
    }
    
    static var defaultParameters: Alamofire.Parameters = [
        "language" : "ko-KR"
    ]
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case  .similerAPI(let contentsType, let contentsId, let page), 
              .recommendationsAPI(let contentsType, let contentsId, let page):
            Self.defaultParameters["page"] = page
            return Self.defaultParameters
        case .imagesAPI(let contentsType, let contentsId, let includeImageLanguage):
            Self.defaultParameters["include_image_language"] = includeImageLanguage
            return Self.defaultParameters
        }
    }
    
    static var headers: HTTPHeaders = [
        APIConstants.HTTPHeaderField.authentication : "Bearer \(MyAuth.readAccessToken)",
        APIConstants.HTTPHeaderField.acceptType : APIConstants.ResponseType.json
    ]
    
    // MARK: Encodings
    var encoding: ParameterEncoding {
        switch self {
        case .similerAPI(let contentsType, let contentsId, let page),
             .recommendationsAPI(let contentsType, let contentsId, let page):
            return URLEncoding.default
        case .imagesAPI(let contentsType, let contentsId, let includeImageLanguage):
            return URLEncoding.default
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = TMDB.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        urlRequest.headers = APIRouter.headers
        
        // Parameters
        if let parameters = parameters {
            print(#function, "urlRequest: \(urlRequest)")
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
