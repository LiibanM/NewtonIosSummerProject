//
//  AddCommsPresenterTests.swift
//  IosSummerProjectTests
//
//  Created by Nikola Drangovski on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//
import XCTest

@testable import IosSummerProject

class AddCommsPresenterTests: XCTestCase {
    
    var addCommsPresenter: AddCommsPresenter!
    var mockApiService: MockApiService!
    var mockAddCommsPresenterDelegate: MockAddCommsPresenterDelegate!
    var mockAddCommsPresenterView: MockAddCommsPresenterView!
    var mockAddCommsPresenter: MockAddCommsPresenter!

    override func setUpWithError() throws {
        mockApiService = MockApiService()
        mockAddCommsPresenterDelegate = MockAddCommsPresenterDelegate()
        mockAddCommsPresenterView = MockAddCommsPresenterView()
        mockAddCommsPresenter = MockAddCommsPresenter()
        addCommsPresenter = AddCommsPresenter(with: mockAddCommsPresenterView, delegate: mockAddCommsPresenterDelegate, mockApiService)
    }
    
    override func tearDownWithError() throws {
        addCommsPresenter = nil
        mockApiService = nil
        mockAddCommsPresenterDelegate = nil
        mockAddCommsPresenterView = nil
    }
    
    func testDidTapPost() {
        
        // Act
        addCommsPresenter.didTapPost()
        
        // Assert
        XCTAssertEqual(1, mockAddCommsPresenterDelegate.goToCommsListCallCount)
    }
    
    func testDidTapSelectCategory() {
        
        // Act
        addCommsPresenter.didTapSelectCategory()
        
        // Assert
        XCTAssertEqual(1, mockAddCommsPresenterDelegate.goToShowCategoriesCallCount)
    }
    
}
