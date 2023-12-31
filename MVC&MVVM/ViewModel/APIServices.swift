//
//  APIServices.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import Foundation

//MARK: MVC Patterns
class APIServices {
    
    let apiRequest:APIRequest
    
    init(apiRequest: APIRequest = httpRequest()) {
        self.apiRequest = apiRequest
    }
    
    func loadApidata(url:URL,completion:@escaping(Result<[Product],errorHandling>) -> Void) {
        
        apiRequest.featchRequest(url: url, completionHandler: { response in
            switch(response) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        })
    }
}



//MARK: MVVM Patterns
class APIServicesViewModel {
    
    let apiRequest: APIRequest
    
    var products: [Product] = [] {
        didSet {
            dataDidChange?()
        }
    }
    
    var loadingError: Error? {
        didSet {
            errorDidChange?()
        }
    }
    
    var dataDidChange: (() -> Void)?
    var errorDidChange: (() -> Void)?
    
    init(apiRequest: APIRequest = httpRequest()) {
        self.apiRequest = apiRequest
    }
    
    func loadApidata(url: URL) {
        apiRequest.featchRequest(url: url) { [weak self] response in
            switch response {
            case .failure(let error):
                self?.loadingError = error
            case .success(let data):
                self?.products = data
            }
        }
    }
}
