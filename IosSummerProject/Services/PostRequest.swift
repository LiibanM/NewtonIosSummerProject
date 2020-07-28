//
//  PostRequest.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

    enum APIError:Error {
        case responseProblem
        case decodingProblem
        case encodingProblem
    }
    
    
    struct APIRequest{
        let resourceURL: URL
        
        init(endpoint: String){
            let resourceString = "http://localhost:3000/\(endpoint)"
            guard let resourceURL = URL(string: resourceString) else{fatalError()}

            self.resourceURL = resourceURL
        }
        
        func save (_ messageToSave:CommsContent, completion: @escaping(Result<CommsContent, APIError>) -> Void){
            
            do{
                var urlRequest = URLRequest(url: resourceURL)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
                
                let dataTask = URLSession.shared.dataTask(with: urlRequest){data, response, _ in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                            jsonData = data else {
                            completion(.failure(.responseProblem))
                            return
                    }
                    do{
                        let messageData = try JSONDecoder().decode(CommsContent.self, from: jsonData)
                        completion(.success(messageData))
                        
                    }catch{
                        completion(.failure(.decodingProblem))
                    }
                }
                dataTask.resume()
            }catch{
            completion(.failure(.encodingProblem))
            }
            
        }
    
   }

    


    

