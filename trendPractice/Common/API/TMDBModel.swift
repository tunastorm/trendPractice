//
//  TMDBModel.swift
//  trendPractice
//
//  Created by 유철원 on 6/24/24.
//

import Foundation
import Alamofire

class TMDBModel {
    static let shared = TMDBModel()
    
    private init () {}
    
    private var similarResponse = TMDBResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
    private var recommandResponse = TMDBResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
    private var pages = ["similar": 1, "recommandations": 1]
    
    
    func requestSimilarAPI(contentsType: APIConstants.ContentsType, contentsId: Int, updateHandler: @escaping ([Result]) -> Void) {
        guard let page = pages["similar"] else {return}
        print(#function, page)
        let router = APIRouter.similerAPI(contentsType: contentsType, contentsId: contentsId, page: page)
        APIClient.request(TMDBResponse.self, router: router,
                          success: { self.complitionHandler($0, router, updateHandler) },
                          failure: errorHandler)
    }
    
    func requestRecommandationsAPI(contentsType: APIConstants.ContentsType, contentsId: Int, updateHandler: @escaping ([Result]) -> Void) {
        guard let page = pages["recommandations"] else {return}
        print(#function, page)
        let router = APIRouter.recommendationsAPI(contentsType: contentsType, contentsId: contentsId, page: page)
        APIClient.request(TMDBResponse.self, router: router,
                          success: { self.complitionHandler($0, router, updateHandler) },
                          failure: errorHandler)
    }
    
    private func complitionHandler(_ response: TMDBResponse, _ router: APIRouter, _ updateHandler: ([Result]) -> Void) {
//        print(#function, response)
        switch router {
        case .similerAPI(let contentsType, let movieId, let page):
            similarResponse = setNewResponse(oldResponse: similarResponse, response: response)
            updateHandler(similarResponse.results)
        case .recommendationsAPI(let contentsType, let movieId, let page):
            recommandResponse = setNewResponse(oldResponse: recommandResponse, response: response)
            print(#function, recommandResponse)
            updateHandler(recommandResponse.results)
        }
    }
    
    private func setNewResponse(oldResponse: TMDBResponse, response: TMDBResponse) -> TMDBResponse {
        var newResponse = oldResponse
        newResponse.page = response.page
        newResponse.results.append(contentsOf: response.results)
        newResponse.totalPages = response.totalPages
        newResponse.totalResults = response.totalResults
        return newResponse
    }
    
    private func pageNation(router: APIRouter) -> Bool {
        switch router {
        case .similerAPI(let contentsType, let contentsId, let page):
            guard let page = pages["similar"], page < similarResponse.totalPages else {return false}
            pages["similar"] = page + 1
            return true
        case .recommendationsAPI(let contentsType, let contentsId, let page):
            guard let page = pages["recommandations"], page < recommandResponse.totalPages else {return false}
            pages["recommandations"] = page + 1
            return true
        }
        return false
    }
    
    private func errorHandler(error: AFError) {
       print(error)
    }
    
}
