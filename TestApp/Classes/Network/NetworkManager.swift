//
//  NetworkManager.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SVProgressHUD

// MARK: AuthTokenHeadersAdapter

class AuthTokenHeadersAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if SessionHelper.isTokenAvailable {
            urlRequest.addValue(User.currentUser.token!, forHTTPHeaderField: "token")
        }
        
        return urlRequest
    }
}


// MARK: NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private let sessionManager = SessionManager()
    
    init() {
        sessionManager.adapter = AuthTokenHeadersAdapter()
    }

    func upload<T:Mappable>(endpoint: EndpointProtocol, images: [String: Data], completion: @escaping (_ result: Result<T>) -> Void ) {
        
        guard let parameters = endpoint.parameters else {
            completion(Result.failure(NetworkError.badInput))
            return
        }

        sessionManager.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in images {
                multipartFormData.append(value, withName: key, fileName: key + ".jpeg", mimeType: "file")
            }

            for (key, value) in parameters {
                if let value = value as? String {
                   multipartFormData.append(value.data(using: .utf8)!, withName: key)
                } else if let value = value as? Float {
                    multipartFormData.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: key, mimeType: "Float")
                }
            }
            
            
        }, with: endpoint, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    SVProgressHUD.showProgress(Float(Progress.fractionCompleted), status: "Uploading")
                })
                
                upload.validate().responseObject(keyPath: endpoint.rootKey) { (response: DataResponse<T> ) in
                    switch response.result {
                    case .success:
                        if let requestResult = response.result.value {
                            completion(Result.success(requestResult))
                        }
                    case .failure:
                        completion(Result.failure(response.result.error!))
                    }
                }
                
            case .failure(let encodingError):
                completion(Result.failure(encodingError))
            }
        })
        
    }
    
    func request<T:Mappable>(endpoint: EndpointProtocol, completion: @escaping (Result<T>) -> Void) {
        
        sessionManager.request(endpoint).validate().responseObject(keyPath: endpoint.rootKey) { (response: DataResponse<T> ) in
            switch response.result {
            case .success:
                if let requestResult = response.result.value {
                    completion(Result.success(requestResult))
                }
            case .failure:
                completion(Result.failure(response.result.error!))
            }
        }

    }
    
    func request<T:Mappable>(endpoint: EndpointProtocol, completion: @escaping (Result<[T]>) -> Void) {
        
        sessionManager.request(endpoint).validate().responseArray(keyPath: endpoint.rootKey) { (response: DataResponse<[T]> ) in
            switch response.result {
            case .success:
                if let requestResult = response.result.value {
                    completion(Result.success(requestResult))
                }
            case .failure:
                completion(Result.failure(response.result.error!))
            }
        }
    }

}
