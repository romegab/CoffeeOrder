//
//  WebService.swift
//  CoffeeOrder
//
//  Created by Ivan Stoilov on 28.05.23.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct Resource<T: Codable> {
    let url: URL
}

class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            guard let result = try?JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(result))
            }
        }.resume()
        
    }
    
}
