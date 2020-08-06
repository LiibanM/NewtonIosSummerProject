//
//  ShowCategoriesPresenterTests.swift
//  IosSummerProjectTests
//
//  Created by Liiban Mukhtar on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//


import XCTest
@testable import IosSummerProject

class ShowCategoriesPresenterTests: XCTestCase {
    

    var showCategoriesPresenter: ShowCategoriesPresenter!
    var mockShowCategoriesPresenterDelegate: MockShowCategoriesPresenterDelegate!
    var mockShowCategoriesPresenterView: MockShowCategoriesPresenterView!
    var mockApiService: MockApiService!

    
    override func setUpWithError() throws {
        mockApiService = MockApiService()
        mockShowCategoriesPresenterDelegate = MockShowCategoriesPresenterDelegate()
        mockShowCategoriesPresenterView = MockShowCategoriesPresenterView()
        showCategoriesPresenter = ShowCategoriesPresenter(with: mockShowCategoriesPresenterView, delegate: mockShowCategoriesPresenterDelegate, mockApiService)
        
        
    }
    
    override func tearDownWithError() throws {
        showCategoriesPresenter = nil
        mockShowCategoriesPresenterDelegate = nil
        mockShowCategoriesPresenterView = nil
        mockApiService = nil
    }
    
    func testAddCategory() throws {
        
        let newCategories = [
            Category(categoryId: 1, categoryName: "abc"),
            Category(categoryId: 2, categoryName: "3245353453453534"),
            Category(categoryId: 3, categoryName: "456"),
            Category(categoryId: 4, categoryName: "879"),
            Category(categoryId: 5, categoryName: "im new")
        ]
        
        var testCategories = [
            Category(categoryId: 1, categoryName: "abc"),
            Category(categoryId: 2, categoryName: "3245353453453534"),
            Category(categoryId: 3, categoryName: "456"),
            Category(categoryId: 4, categoryName: "879")
        ]
        
        
        testCategories.append(Category(category_id: 1, category_name: "abc"))
        
        XCTAssertEqual(newCategories.count, testCategories.count)
        
       
    }
    
}
