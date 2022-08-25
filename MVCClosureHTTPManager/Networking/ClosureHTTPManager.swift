//
//  ClosureHTTPManager.swift
//  MVCClosureHTTPManager
//
//  Created by Jyoti on 25/08/2022.
//

import Foundation

class ClosureHTTPManager {
    static let shared : ClosureHTTPManager = ClosureHTTPManager()
    
    enum HTTPError : Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func getUrl(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
                }
            
            completionBlock(.success(responseData))
        }
        task.resume()
    }
}
