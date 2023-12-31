//
//  HttpRequest.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import Foundation

enum errorHandling : Error {
    
    case badURL
    case noDataFound
    case modelDatafail
    
}

protocol APIRequest {
    func featchRequest(url:URL?,completionHandler:@escaping(Result<[Product],errorHandling>) -> Void)
}


class httpRequest:APIRequest {
    
    func featchRequest(url:URL?,completionHandler:@escaping(Result<[Product],errorHandling>) -> Void) {
        
        guard let url = url else { return completionHandler(.failure(.badURL))}
        
        URLSession.shared.dataTask(with: url, completionHandler: { data,respnose,error in
            
            guard let respnose =  respnose as? HTTPURLResponse, respnose.statusCode == 200 else {  return completionHandler(.failure(.noDataFound))}
            
            if let data = data {
                do {
                    let jsonDecode = try JSONDecoder().decode(Welcome.self, from: data)
                    
                    completionHandler(.success(jsonDecode.products))
                    
                }catch(_ ){
                    completionHandler(.failure(.modelDatafail))
                }
            }else {
                completionHandler(.failure(.noDataFound))
            }
        }).resume()
    }
    
}
