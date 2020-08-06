//
//  MockAddCommPresenterDelegate.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 29/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

@testable import IosSummerProject

class MockAddCommsPresenterDelegate: AddCommsPresenterDelegate {
    
    var goToCommsListCallCount = 0
    var goToShowCategoriesCallCount = 0
    
    func goToCommsList() {
        goToCommsListCallCount += 1
    }
    
    func goToShowCategories(currentPage: String) {
        goToShowCategoriesCallCount += 1
    }
}
