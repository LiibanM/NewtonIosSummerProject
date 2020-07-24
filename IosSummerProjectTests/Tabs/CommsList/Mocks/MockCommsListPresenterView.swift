//
//  MockCommsListPresenterView.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 23/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject

class MockCommsListPreseneterView: CommsListPresenterView {
    
    var errorDidOccur = "Error"
    var didSetCommsData = 0
    
    func errorOccured(message: String) {
        
    }
    
    func setCommsData(with data: [Article]) {

    }
    
    
}
