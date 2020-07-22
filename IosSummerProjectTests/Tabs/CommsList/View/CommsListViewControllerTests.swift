//
//  CommsListViewControllerTests.swift
//  IosSummerProjectTests
//
//  Created by Akash Mair on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject

class CommsListViewControllerTests: XCTestCase {
    
    var commsListViewController: CommsListViewController!
    var mockCommsListPresenter: MockCommsListPresenter!

    override func setUpWithError() throws {
        mockCommsListPresenter = MockCommsListPresenter()
        commsListViewController = CommsListViewController.instantiate(storyboard: "CommsList")
        commsListViewController.commsListPresenter = mockCommsListPresenter
        
        XCTAssertNotNil(commsListViewController.view)
    }

    override func tearDownWithError() throws {
        commsListViewController = nil
        mockCommsListPresenter = nil
    }
    
    func testAddButtonTapped() {
        // Arrange
        
        // Act
        commsListViewController.addButtonTapped((Any).self)
        
        // Assert
        XCTAssertEqual(1, mockCommsListPresenter.didTapAddCommsCount)
    }
    
    func testLoadComms() {
//        commsListViewController.comms
        
        
        commsListViewController.viewDidLoad()
        
        XCTAssertEqual(commsListViewController.comms)

    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
