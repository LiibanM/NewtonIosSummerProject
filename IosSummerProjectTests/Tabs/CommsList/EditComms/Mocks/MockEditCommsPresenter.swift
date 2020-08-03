//
//  MockEditCommsPresenter.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

@testable import IosSummerProject

class MockEditCommsPresenter: EditCommsPresenterProtocol {
    
    var didTapSelectCategoryCount = 0
    var didLoadCommCount = 0
    var didTapSaveComms = 0
    
    func didTapSelectCategory() {
        didTapSelectCategoryCount += 1
    }
    
    func selectedCategory(with category: IosSummerProject.Category) {
    }
    
    func loadComm() {
        didLoadCommCount += 1
    }
    
    func didTapSave(for article: Article) {
        didTapSaveComms += 1
    }

}
