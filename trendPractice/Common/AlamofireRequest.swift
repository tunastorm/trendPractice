//
//  AlamofireRequest.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit
import Alamofire


protocol AlamofireRequest {
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Alamofire.Parameters)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, headers: Alamofire.HTTPHeaders)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Alamofire.Parameters, headers: Alamofire.HTTPHeaders)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding, headers: Alamofire.HTTPHeaders)
    
    
    func getHTTPRequest<T:Decodable>(URL: String, parameters: Parameters, decodingType: T.Type, callback: ((_ data: T)->())? )

    func getHTTPRequest<T:Decodable>(URL: String, headers: Alamofire.HTTPHeaders, decodingType: T.Type, callback: ((_ data: T)->())?)
    
    func getHTTPRequest<T:Decodable>(URL: String, parameters: Alamofire.Parameters, headers: Alamofire.HTTPHeaders, decodingType: T.Type, callback: ((_ data: T)->())?)

    
    func postHTTPRequest<T:Decodable>(URL: String, parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding, decodingType: T.Type, callback: ((_ data: T)->())?)

    func postHTTPRequest<T:Decodable>(URL: String, headers: Alamofire.HTTPHeaders, encoding: Alamofire.ParameterEncoding, decodingType: T.Type, callback: ((_ data: T)->())?)
    
    func postHTTPRequest<T:Decodable>(URL: String, parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding, headers: Alamofire.HTTPHeaders, decodingType : T.Type, callback: ((_ data: T)->())?)
}


extension AlamofireRequest {
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Alamofire.Parameters) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters)
        .responseString{ response in
            print("| Where |\n", self.self, "\n    .", #function, "\n| Response String |\n", response)
        }
    }
    
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, headers: Alamofire.HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   headers: headers)
        .responseString{ response in
            print("| Where |\n", self.self, "\n    .", #function, "\n| Response String |\n", response)
        }
    }
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Alamofire.Parameters, headers: Alamofire.HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .responseString{ response in
            print("| Where |\n", self.self, "\n    .", #function, "\n| Response String |\n", response)
        }
    }
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters, encoding: Alamofire.ParameterEncoding, headers: Alamofire.HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .responseString{ response in
            print("| Where |\n", self.self, "\n    .", #function, "\n| Response String |\n", response)
        }
    }
    
    func getHTTPRequest<T>(URL: String, parameters: Alamofire.Parameters, decodingType: T.Type, callback: ((_ data: T)->())?) where T : Decodable {
        AF.request(URL,
                   method: .get,
                   parameters: parameters)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\n| Where |\n", self.self, "\n    .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getHTTPRequest<T>(URL:String, headers: Alamofire.HTTPHeaders, decodingType: T.Type, callback: ((_ data: T)->())?) where T: Decodable {
        
        AF.request(URL,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\n| Where |\n", self.self, "\n    .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getHTTPRequest<T>(URL:String, parameters: Alamofire.Parameters, headers: Alamofire.HTTPHeaders, decodingType: T.Type, callback: ((_ data: T)->())?) where T: Decodable {
        
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
//                print("| Response Status: ", result.statusCode,  " |\n| Where |\n", self.self, "\n  .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ",", #function)
            }
            
            switch response.result {
            case .success(let value):
//                print("| Decoding SUCCESS |\n| Where | ", self.self, ".", #function)
//                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postHTTPRequest<T>(URL: String, parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding, decodingType : T.Type, callback: ((_ data: T)->())?) where T: Decodable {
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: encoding)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\n| Where |\n", self.self, "\n    .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postHTTPRequest<T>(URL: String, headers: Alamofire.HTTPHeaders, encoding: Alamofire.ParameterEncoding, decodingType : T.Type, callback: ((_ data: T)->())?) where T: Decodable {
        AF.request(URL,
                   method: .post,
                   encoding: encoding,
                   headers: headers)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\n| Where |\n", self.self, "\n    .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func postHTTPRequest<T>(URL: String, parameters: Alamofire.Parameters, encoding: Alamofire.ParameterEncoding, headers: Alamofire.HTTPHeaders, decodingType : T.Type, callback: ((_ data: T)->())?) where T: Decodable {
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .responseDecodable(of: decodingType) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\n| Where |\n", self.self, "\n    .", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                callback?(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}


