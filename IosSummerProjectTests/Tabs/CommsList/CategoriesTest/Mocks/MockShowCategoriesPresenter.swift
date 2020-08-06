//
//  MockShowCategoriesPresenter.swift
//  IosSummerProjectTests
//
//  Created by Liiban Mukhtar on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit
@testable import IosSummerProject

class MockShowCategoriesPresenter: ShowCategoriesPresenterProtocol
{
    
       var didSendCategory = 0
       var didLoadDataCount = 0
       var didselectCategoryCount = 0
    
    func loadCategories() {
        didLoadDataCount+=1
    }

    func didSelectCategory(with category: IosSummerProject.Category) {
        didselectCategoryCount+=1
    }

    func sendCategory(with category: IosSummerProject.Category) {
        didSendCategory+=1
    }

}
