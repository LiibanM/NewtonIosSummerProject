//
//  PostRequest.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

    enum APIError: Error {
        //FILIP - unsure whether this is descriptive enough and how to make the more descriptive
        case backEndApiResponseProblem // These errors are no descriptive of what the error is
        case dataDecodingProblem
        case dataEncodingProblem
    }
    // Create custom errors to be useful for your own code and for better handling
    // If this is a gerneric API request, then these errors need to be descriptive
    
    struct APIRequest {
        let resourceURL: URL
        
        init(endpoint: String){
            
            let resourceString = "http://localhost:3000/\(endpoint)"
            
            guard let resourceURL = URL(string: resourceString) else {
                fatalError()
            }

            self.resourceURL = resourceURL
        }
        
        func save(
            _ messageToSave: CommsContent,
            completion: @escaping(Result<CommsContent, APIError>) -> Void) {
            
            do {
                var urlRequest = URLRequest(url: resourceURL)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
                
                // Spacing
                let dataTask = URLSession.shared.dataTask(with: urlRequest) {
                    data, response, _ in
                    
                    // This is very hard to read, the status code check should happen outside the guard let
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                            jsonData = data else {
                            completion(.failure(.backEndApiResponseProblem))
                            return
                    }
                    
                    
                    do {
                        let messageData = try JSONDecoder().decode(CommsContent.self, from: jsonData)
                        
                        completion(.success(messageData))
                    
                    } catch {
                        completion(.failure(.dataDecodingProblem))
                    }
                }
                dataTask.resume()
                
            } catch {
                completion(.failure(.dataEncodingProblem))
            }
            
        }
    
   }

    


    

