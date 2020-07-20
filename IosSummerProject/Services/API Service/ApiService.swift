//
//  ApiService.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchData<T:Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) ->
           Void)
}

enum NetworkError: Error {
    case badUrl, requestFailed, unknown, failedToDecode, unAuthenticated
}

class ApiService: ApiServiceProtocol {
    func fetchData<T:Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) ->
        Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        
        let session = URLSession(configuration: .default)
     
        let task = session.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                do{
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                }catch{
                    completion(.failure(.failedToDecode))
                }
            } else if error != nil {
                completion(.failure(.requestFailed))
            } else {
                completion(.failure(.unknown))
            }
        }
        task.resume()
    }
}
