//
//  APIRouter.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation

import Alamofire

enum APIConstants {

    static let authentication = "Bearer \(MyAuth.readAccessToken)"
    static let token = ""
    static let includeImageLanguage = "en, jp"
    
    enum HTTPHeaderField {
        static let authentication = "Authorization"
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
        static let acceptEncoding = "Accept-Encoding"
        static let xAuthToken = "x-auth-token"
    }

    enum ContentType {
        static let json = "application/json"
    }
    
    enum MediaType: String, Decodable {
        case all = "all"
        case movie = "movie"
        case tv = "tv"
    }
    
    enum TimeWindow {
        case day
        case week
    }
}


enum APIRouter: URLRequestConvertible {
 
    // MARK: Request Types
    case trendingAPI(contentsType: APIConstants.MediaType,timeWindow: APIConstants.TimeWindow)
    case genreAPI(contentsType: APIConstants.MediaType)
    case creditsAPI(contentsType: APIConstants.MediaType, contentsId: Int)
    case similerAPI(contentsType: APIConstants.MediaType, contentsId: Int, page: Int)
    case recommendationsAPI(contentsType: APIConstants.MediaType, contentsId: Int, page: Int)
    case imagesAPI(contentsType: APIConstants.MediaType, contentsId: Int, includeImageLanguage: String)
    

    // MARK: Methods
    var method: HTTPMethod {
        switch self {
        case .trendingAPI, .genreAPI, .creditsAPI, .imagesAPI, .similerAPI, .recommendationsAPI:
            return .get
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case .trendingAPI(let contentsType, let timeWindow):
            return "trending/\(contentsType)/\(timeWindow)"
        case .genreAPI(contentsType: let contentsType):
            return "genre/\(contentsType)/list"
        case .creditsAPI(let contentsType, let contentsId):
            return "\(contentsType)/\(contentsId)/credits"
        case .similerAPI(let contentsType, let contentsId, let page):
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
        case .trendingAPI, .genreAPI, .creditsAPI:
            return APIRouter.defaultParameters
        case .similerAPI(let contentsType, let contentsId, let page),
             .recommendationsAPI(let contentsType, let contentsId, let page):
            Self.defaultParameters["page"] = page
            return Self.defaultParameters
        case .imagesAPI(let contentsType, let contentsId, let includeImageLanguage):
            Self.defaultParameters["include_image_language"] = includeImageLanguage
            return Self.defaultParameters
        }
    }
    
    static var headers: HTTPHeaders = [
        APIConstants.HTTPHeaderField.authentication : APIConstants.authentication,
        APIConstants.HTTPHeaderField.acceptType : APIConstants.ContentType.json
    ]
    
    // MARK: Encodings
    var encoding: ParameterEncoding {
        switch self {
        case .trendingAPI, .genreAPI, .creditsAPI, .similerAPI, .recommendationsAPI, .imagesAPI:
            return URLEncoding.default
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = TMDB.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        urlRequest.headers = Self.headers
        
        // Parameters
        if let parameters = parameters {
            print(#function, "urlRequest: \(urlRequest)")
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
