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
     func sendData<T: Codable>(url: String, payload: T, completion: @escaping (Result<T, NetworkError>) -> ())
}

enum NetworkError: Error {
    case badUrl, requestFailed, unknown, failedToDecode, unAuthenticated, failedToEncode
}

class ApiService: ApiServiceProtocol {
    
    func fetchData<T:Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) ->
        Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
//        let token = ""
        let _ = URLRequest(url)
//        request.addValue("\(Constants.ApiService.bearer) \(token)", forHTTPHeaderField: Constants.ApiService.forHTTPHeaderField)
        
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
    
    func sendData<T: Codable>(url: String, payload: T, completion: @escaping (Result<T, NetworkError>) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(payload)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                                 jsonData = data else {
                                 completion(.failure(.requestFailed))
                                 return
                }
                do {
                    let data = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(data))
                    } catch {
                        completion(.failure(.failedToDecode))
                    }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.failedToEncode))
        }
    }
}


extension URLRequest {
    init(_ url: URL) {
        self.init(url: url)
        let token = ""
        self.setValue("\(Constants.ApiService.bearer) \(token)", forHTTPHeaderField: Constants.ApiService.forHTTPHeaderField)
    }
}
