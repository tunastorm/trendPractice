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
        
        var kr: String {
            switch self {
            case .movie:
                "영화"
            case .tv:
                "TV시리즈"
            default: "콘텐츠"
            }
        }
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
    case searchAPI(query: String, page: Int)
    case imagesAPI(contentsType: APIConstants.MediaType, contentsId: Int)
    case videoAPI(contentsType: APIConstants.MediaType, contentsId: Int)
    
    

    // MARK: Methods
    var method: HTTPMethod {
        switch self {
        case .trendingAPI, .genreAPI, .creditsAPI, .imagesAPI, .similerAPI, .recommendationsAPI, .searchAPI, .videoAPI:
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
        case .imagesAPI(let contentsType, let contentsId):
            return "\(contentsType)/\(contentsId)/images"
        case .videoAPI(let contentsType, let contentsId):
            return "\(contentsType)/\(contentsId)/videos"
        case .searchAPI:
            return "search/multi"
        }
    }
    
    static var baseParameters: Parameters = [
        "language" : "ko-KR"
    ]
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .trendingAPI, .genreAPI, .creditsAPI:
            return APIRouter.baseParameters
        case .similerAPI(let contentsType, let contentsId, let page),
             .recommendationsAPI(let contentsType, let contentsId, let page):
            Self.baseParameters["page"] = page
            return Self.baseParameters
        case .imagesAPI(let contentsType, let contentsId):
            Self.baseParameters["include_image_language"] = APIConstants.includeImageLanguage
            return Self.baseParameters
        case .videoAPI(let contentsType, let contentsId):
            Self.baseParameters["include_image_language"] = APIConstants.includeImageLanguage
            return Self.baseParameters
        case .searchAPI(let query, let page):
            Self.baseParameters["query"] = query
            Self.baseParameters["include_adult"] = false
            Self.baseParameters["page"] = page
            return Self.baseParameters
        }
    }
    
    static var headers: HTTPHeaders = [
        APIConstants.HTTPHeaderField.authentication : APIConstants.authentication,
        APIConstants.HTTPHeaderField.acceptType : APIConstants.ContentType.json
    ]
    
    // MARK: Encodings
    var encoding: ParameterEncoding {
        switch self {
        case .trendingAPI, .genreAPI, .creditsAPI, .similerAPI, .recommendationsAPI, .imagesAPI, .searchAPI, .videoAPI:
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
