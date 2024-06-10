//
//  AlamofireRequest.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit
import Alamofire


protocol AlamofireRequest {
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, headers: HTTPHeaders)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters, headers: HTTPHeaders)
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders)
    
    
    func getHTTPRequest<T>(URL: String, parameter: Parameters, decodingType: T, callback: ())
    
    func getHTTPRequest<T>(URL: String, headers: HTTPHeaders, decodingType: T, callback: ())
    
    func getHTTPRequest<T>(URL: String, parameter: Parameters, headers: HTTPHeaders, decodingType: T, callback: ())
    

    func postHTTPRequest<T>(URL: String, parameter: Parameters, encoding: ParameterEncoder, decodingType : T, callback: ())
    
    func postHTTPRequest<T>(URL: String, headers: HTTPHeaders, encoding: ParameterEncoder, decodingType : T, callback: ())
    
    func postHTTPRequest<T>(URL: String, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, decodingType : T, callback: ())
}


extension AlamofireRequest {
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters)
        .responseString{ response in
            if let result = response.response {
                print("| Where | ", self.self, ",", #function, "\n| Response String | ", result)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
        }
    }
    
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, headers: HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   headers: headers)
        .responseString{ response in
            if let result = response.response {
                print("| Where | ", self.self, ",", #function, "\n| Response String | ", result)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
        }
    }
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters, headers: HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .responseString{ response in
            if let result = response.response {
                print("| Where | ", self.self, ",", #function, "\n| Response String | ", result)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
        }
    }
    
    func HTTPResponseString(_ httpMethod: HTTPMethod, URL: String, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders) {
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .responseString{ response in
            if let result = response.response {
                print("| Where | ", self.self, ",", #function, "\n| Response String | ", result)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
        }
    }
    
    func getHTTPRequest<T: Decodable>(URL:String, headers: HTTPHeaders, decodingType: T, callback updateData: ()) -> T {
        
        AF.request(URL,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: T.self) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\nWhere:", self.self, ", ", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                updateData
            case .failure(let error):
                print(error)
            }
        } as! T
    }
    
    func getHTTPRequest<T: Decodable>(URL:String, headers: HTTPHeaders, parameters: Parameters, decodingType: T, callback updateData: ()) -> T {
        
        AF.request(URL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .responseDecodable(of: T.self) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\nWhere:", self.self, ", ", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                updateData
            case .failure(let error):
                print(error)
            }
        } as! T
    }
    
    func postHTTPRequest<T: Decodable>(URL: String, headers: HTTPHeaders, encoding: ParameterEncoder, decodingType : T, callback updateData: ()) {
        
    }
    
    func postHTTPRequest<T: Decodable>(URL: String, parameters: Parameters, encoding: ParameterEncoder, decodingType : T, callback updateData: ()) {
        
    }
    
    func postHTTPRequest<T: Decodable>(URL: String, headers: HTTPHeaders, parameters: Parameters, encoding: ParameterEncoder, decodingType : T, callback updateData: ()) {
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: T.self) { response in
            if let result = response.response {
                print("| Response Status: ", result.statusCode, " |\nWhere:", self.self, ", ", #function)
            } else {
                print("| Request Connectuon Failed |\n| Where | ", self.self, ", ", #function)
            }
            
            switch response.result {
            case .success(let value):
                print("| Decoding SUCCESS |\n| Where | ", self.self, ", ", #function)
                print("| value | ", value)
                updateData
            case .failure(let error):
                print(error)
            }
        }
    }
}


