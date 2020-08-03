//
//  AddCommsViewControllerTests.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject

class AddCommsViewControllerTests: XCTestCase {
    
    var addCommsViewController: AddCommsViewController!
    var mockAddCommsPresenter: MockAddCommsPresenter!

    override func setUpWithError() throws {
        mockAddCommsPresenter = MockAddCommsPresenter()
        addCommsViewController = AddCommsViewController.instantiate(storyboard: "AddComms")
        addCommsViewController.addCommsPresenter = mockAddCommsPresenter
        
        XCTAssertNotNil(addCommsViewController.view)
    }

    override func tearDownWithError() throws {
        addCommsViewController = nil
        mockAddCommsPresenter = nil
    }

    func testPostButtonTapped() throws {
        addCommsViewController.postButtonTapped((Any).self)
        
        
        XCTAssertEqual(1, mockAddCommsPresenter.didTapPostCount)
    }
    
    //image picker tests ?
    
    
    func testSelectCategoryButtonTapped() throws {
        addCommsViewController.selectCategoryButtonTapped((Any).self)
        
        
        XCTAssertEqual(1, mockAddCommsPresenter.didTapSelectCategoryCount)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
