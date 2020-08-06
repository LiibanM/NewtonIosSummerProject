//
//  ShowCategoriesViewControllerTests.swift
//  IosSummerProjectTests
//
//  Created by Liiban Mukhtar on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject

class ShowCategoriesViewControllerTests: XCTestCase {
 
    var showCategoriesViewController: ShowCategoriesViewController!
    var mockShowCategoriesPresenter: MockShowCategoriesPresenter!
    
    
    override func setUpWithError() throws {
        mockShowCategoriesPresenter = MockShowCategoriesPresenter()
        showCategoriesViewController = ShowCategoriesViewController.instantiate(storyboard: "ShowCategories")
        showCategoriesViewController.showCategoriesPresenter = mockShowCategoriesPresenter
        
        XCTAssertNotNil(showCategoriesViewController.view)
        
        showCategoriesViewController.categoryTextField.text = "hello"
    }
    
  
    override func tearDownWithError() throws {
        showCategoriesViewController = nil
        mockShowCategoriesPresenter = nil
    }
    
    
    func testSetCategoreis() {
        // Arrange
        var categories = [IosSummerProject.Category]()
       
        
        // Act
        showCategoriesViewController.setCategories(with: categories)
        
        
        // Assert
        XCTAssertEqual(categories.count, showCategoriesViewController.categories.count)
    }
    
    func testAddCategoriesTapped() throws {
        
        showCategoriesViewController.addCategoryButtonTapped((Any).self)
        XCTAssertEqual(mockShowCategoriesPresenter.didSendCategory, 1)
    }
    
}
