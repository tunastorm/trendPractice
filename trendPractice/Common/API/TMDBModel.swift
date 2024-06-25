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
    
    private var TMDBList = [
        TMDBResponse(page: 1, results: [], totalPages: 1, totalResults: 0),
        TMDBResponse(page: 1, results: [], totalPages: 1, totalResults: 0),
    ]
    
    private var imagesList = [
        ImagesResponse(id: 0, posters: [])
    ]
    
    private var pages = [1, 1]
    
    
    func requestAPI<T:Decodable>(responseType: T.Type, router: APIRouter, completionHandler: @escaping (T) -> Void) {
        APIClient.request(responseType.self, 
                          router: router,
                          success: completionHandler,
                          failure: errorHandler)
    }
    
    func updateSimilar(contentsType: APIConstants.ContentsType, 
                       contentsId: Int, completionHandler: @escaping (TMDBResponse) -> Void) {
        let router = APIRouter.similerAPI(contentsType: contentsType , contentsId: contentsId, page: pages[0])
        requestAPI(responseType: TMDBResponse.self, 
                   router: router, completionHandler: completionHandler)
    }
    
    func updateRecommandations(contentsType: APIConstants.ContentsType, 
                               contentsId: Int, completionHandler: @escaping (TMDBResponse) -> Void) {
        let router = APIRouter.recommendationsAPI(contentsType: contentsType, contentsId: contentsId, page: pages[1])
        requestAPI(responseType: TMDBResponse.self, 
                   router: router, completionHandler: completionHandler)
    }
    
    func updateImages(contentsType: APIConstants.ContentsType,
                      contentsId: Int, completionHandler: @escaping (ImagesResponse) -> Void) {
        let router = APIRouter.imagesAPI(contentsType: contentsType, contentsId: contentsId,
                                         includeImageLanguage: APIConstants.includeImageLanguage)
        requestAPI(responseType: ImagesResponse.self, 
                   router: router, completionHandler: completionHandler)
    }
    
    func clearResponse<T:Decodable>(oldIndex: Int, responseType: T.Type) {
        switch responseType {
        case is TMDBResponse.Type:
            TMDBList[oldIndex] = TMDBResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
        case is ImagesResponse.Type:
            imagesList[oldIndex] = ImagesResponse(id: 0, posters: [])
        default: return
        }
    }
    
    func setNewResponse<T:Decodable>(oldIndex: Int, response: T) {
       
        switch T.self {
        case is TMDBResponse.Type:
            let newResponse = response as! TMDBResponse
            TMDBList[oldIndex].page = newResponse.page
            TMDBList[oldIndex].results.append(contentsOf: newResponse.results)
            TMDBList[oldIndex].totalPages = newResponse.totalPages
            TMDBList[oldIndex].totalResults = newResponse.totalResults
        case is ImagesResponse.Type:
            let newResponse = response as! ImagesResponse
            imagesList[oldIndex].id = newResponse.id
            imagesList[oldIndex].posters.append(contentsOf: newResponse.posters)
        default: return
        }
    }
    
    func getSimilarResults() -> [Result] {
        return TMDBList[0].results
    }
    
    func getRecommandationsResults() -> [Result] {
        return TMDBList[1].results
    }
    
    func getPosters() -> [Poster] {
        return imagesList[0].posters
    }
    
    private func errorHandler(error: AFError) {
       print(error)
    }
}