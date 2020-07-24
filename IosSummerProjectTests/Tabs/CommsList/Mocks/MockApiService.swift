//
//  MockApiService.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 23/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject

class MockApiService: ApiServiceProtocol {
    func fetchData<T>(url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
    }
    
    
}
