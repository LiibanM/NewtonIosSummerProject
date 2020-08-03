//
//  MockAddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject

class MockAddCommsPresenter: AddCommsPresenterProtocol {
    
    var didTapSelectCategoryCount = 0
    var didTapPostCount = 0
    var onTapUploadImageCount = 0
    
    
    func selectedCategory(_ category: Category) {
        
    }
    
    func didTapSelectCategory() {
        didTapSelectCategoryCount += 1
    }
    
    func didTapPost() {
        didTapPostCount += 1
    }
    
    func onTapUploadImage() {
        onTapUploadImageCount += 1
    }
}
