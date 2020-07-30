//
//  ApiService.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import KeychainSwift

protocol ApiServiceProtocol {
    func fetchData<T:Decodable>(url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) ->
           Void)
    func addNewArticle(url: String, payload: NewArticle, completion: @escaping (Result<Article, NetworkError>) -> ())
    func authenticateUser(url: String, payload: GoogleToken, completion: @escaping (Result<Token, NetworkError>) -> ())
    func editAnArticle(url: String, payload: EditArticle, completion: @escaping (Result<Article, NetworkError>) -> ())
    func addACategory(url: String, payload: AddCategory, completion: @escaping (Result<Category, NetworkError>) -> ())
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
        var urlReq = URLRequest(url)
        let session = URLSession(configuration: .default)
     
        let task = session.dataTask(with: urlReq) { (data, urlResponse, error) in
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
    
    
    func authenticateUser(url: String, payload: GoogleToken, completion: @escaping (Result<Token, NetworkError>) -> ()) {
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
                        let data = try JSONDecoder().decode(Token.self, from: jsonData)
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
    
    
    
    func addNewArticle(url: String, payload: NewArticle, completion: @escaping (Result<Article, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        do {
            var urlRequest = URLRequest(url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(payload)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let jsonData = data else {
                    completion(.failure(.requestFailed))
                    return
                }
                do {
                    let data = try JSONDecoder().decode(Article.self, from: jsonData)
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
    
    func editAnArticle(url: String, payload: EditArticle, completion: @escaping (Result<Article, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        do {
            var urlRequest = URLRequest(url)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(payload)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let jsonData = data else {
                    completion(.failure(.requestFailed))
                    return
                }
                do {
                    let data = try JSONDecoder().decode(Article.self, from: jsonData)
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
    
    func addACategory(url: String, payload: AddCategory, completion: @escaping (Result<Category, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.badUrl))
            return
        }
        do {
            var urlRequest = URLRequest(url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(payload)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let jsonData = data else {
                    completion(.failure(.requestFailed))
                    return
                }
                do {
                    let data = try JSONDecoder().decode(Category.self, from: jsonData)
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
        let keyChainService = KeychainSwift()
        let token = keyChainService
            .get("userJwtToken")
        if let token = token {
            self.setValue("\(Constants.ApiService.bearer) \(token)", forHTTPHeaderField: Constants.ApiService.forHTTPHeaderField)
        }
    }
}
