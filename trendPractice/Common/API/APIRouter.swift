//
//  APIRouter.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation

import Alamofire

enum APIConstants {
    // MARK: API Endpoint
//    case trendingAPI
//    case genreAPI
//    case creditsAPI
    case searchAPI
    
    // MARK: Base URL
    var baseURL: URL {
        switch self {
//        case .trendingAPI: return URL(string:"https://api.themoviedb.org/3/trending")
//        case .genreAPI: return URL(string:"https://api.themoviedb.org/3/genre)
//        case .creditsAPI: return  "https://api.themoviedb.org/3/{MediaType}/{Id}/credits"
        case .searchAPI: return URL(string:"https://api.themoviedb.org/3/search")!
        }
    }
    static let token = ""
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case xAuthToken = "x-auth-token"
}

enum ContentType: String {
    case json = "application/json"
}


enum APIRouter: URLRequestConvertible {
    // MARK: Request Types
    case getSearchMovie
    case getSearchTV
//    case getTrendingMovie
//    case getTrendingTV
    
    // MARK: Methods
    var method: HTTPMethod {
        switch self {
        case .getSearchMovie, .getSearchTV:
            return .get
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case .getSearchMovie:
            return "/movie"
        case .getSearchTV:
            return "/tv"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getSearchMovie, .getSearchTV:
            return MyAuth.searchParameters
        }
    }
    
    // MARK: Encodings
    var encoding: ParameterEncoding {
        switch self {
        case .getSearchMovie, .getSearchTV:
            return URLEncoding.default
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        var url = APIConstants.searchAPI.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(APIConstants.token,
                            forHTTPHeaderField: HTTPHeaderField.xAuthToken.rawValue)
        
        // Parameters
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
