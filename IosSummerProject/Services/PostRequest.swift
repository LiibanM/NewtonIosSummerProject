//
//  PostRequest.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

    // Spacing between : and Error
    enum APIError:Error {
        case responseProblem // These errors are no descriptive of what the error is
        case decodingProblem
        case encodingProblem
    }
    // Create custom errors to be useful for your own code and for better handling
    // If this is a gerneric API request, then these errors need to be descriptive
    
    
    // Spacing between APIRequest and {
    struct APIRequest{
        let resourceURL: URL
        
        init(endpoint: String){
            let resourceString = "http://localhost:3000/\(endpoint)"
            guard let resourceURL = URL(string: resourceString) else{fatalError()}
            // This looks is hard to read, add spacing and new lines
            
            // With '{' you should always add spaces after and before so it is readable
            
            
//            guard let resourceURL = URL(string: resourceString) else {
//                fatalError()
//            }

            self.resourceURL = resourceURL
        }
        
        // Add a space between colon and object type - hard to read otherwise
        // Also use new lines to split parameters onto different lines for readability
        // Add space before {
        // Remove space between 'save' and (
        
        func save (_ messageToSave:CommsContent, completion: @escaping(Result<CommsContent, APIError>) -> Void){
            
//        ---- Example of more readable function ----
//        func save(
//            _ messageToSave:CommsContent,
//            completion: @escaping(Result<CommsContent, APIError>) -> Void) {
            
            
            do{ // Add space between do and { - this goes for everywhere in this function
                var urlRequest = URLRequest(url: resourceURL)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try JSONEncoder().encode(messageToSave)
                
                // Spacing
                let dataTask = URLSession.shared.dataTask(with: urlRequest){data, response, _ in
                    
                    // This is very hard to read, the status code check should happen outside the guard let
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let
                            jsonData = data else {
                            completion(.failure(.responseProblem))
                            return
                    }
                    
                    
//                    guard let httpResponse = response as? HTTPURLResponse,
//                          let jsonData = data else {
//                            completion(.failure(.responseProblem))
//                            return
//                    }
                    
                    // Spacing
                    do{
                        let messageData = try JSONDecoder().decode(CommsContent.self, from: jsonData)
                        completion(.success(messageData))
                    
                    // Spacing
                    }catch{
                        completion(.failure(.decodingProblem))
                    }
                }
                dataTask.resume()
                
            // Spacing
            }catch{
                // Lining of this code should be tabbed
            completion(.failure(.encodingProblem))
            }
            
        }
    
   }

    


    

