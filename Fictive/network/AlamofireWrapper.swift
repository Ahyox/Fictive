//
//  AlamofireWrapper.swift
//  Fictive
//
//  Created by Prof Ahyox on 24/11/2020.
//

import Foundation
import Alamofire

class AlamofireWrapper : NSObject {
    static let sharedInstance = AlamofireWrapper()
    
    func postRequest<T: Decodable>(urlComponents:URLComponents, success:@escaping(T)-> Void, failure:@escaping(Error)-> Void) {
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        AF.request(request)
            .responseDecodable(of: T.self) {response in
            
                guard let data = response.value else {
                    failure(response.error!)
                    return
                }
                
                success(data)
                
            }
    }
    
    
    func putRequest<T: Decodable>(urlComponents:URLComponents, success:@escaping(T)-> Void, failure:@escaping(Error)-> Void) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": "iOS",
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = headers
        
        AF.request(request)
            .responseDecodable(of: T.self) {response in
            
                guard let data = response.value else {
                    failure(response.error!)
                    return
                }
                
                success(data)
                
            }
    }
    
    
    
    func getRequest<T: Decodable>(url:String, success:@escaping(T)-> Void, failure:@escaping(Error)-> Void) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "User-Agent": "iOS",
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) {response in
            
                guard let data = response.value else {
                    failure(response.error!)
                    return
                }
                
                success(data)
        }
    }
}

