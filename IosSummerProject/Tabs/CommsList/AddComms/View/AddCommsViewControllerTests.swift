//
//  AddCommsViewControllerTests.swift
//  IosSummerProjectTests
//
//  Created by Nikola Drangovski on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest

@testable import IosSummerProject
class AddCommsViewControllerTests: XCTestCase {
    
    var addCommsViewController: AddCommsViewController!

    override func setUpWithError() throws {
        addCommsViewController = AddCommsViewController.instantiate(storyboard: "AddCommsViewController")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        addCommsViewController = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUploadImageButtonTapped(){
        
    }

}
