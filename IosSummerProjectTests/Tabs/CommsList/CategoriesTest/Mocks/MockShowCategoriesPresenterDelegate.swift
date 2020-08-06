//
//  MockShowCategoriesPresenterDelegate.swift
//  IosSummerProjectTests
//
//  Created by Liiban Mukhtar on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

@testable import IosSummerProject

class MockShowCategoriesPresenterDelegate: ShowCategoriesPresenterDelegate{
    
 var didSelectCategoryCount = 0

 func didSelectCategory(with category: IosSummerProject.Category) {
    didSelectCategoryCount+=1
 }

}

