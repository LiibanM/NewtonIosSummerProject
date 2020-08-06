//
//  EditCommsViewControllerTests.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject

import Kingfisher

class EditCommsViewControllerTests: XCTestCase {
    
    var editCommsViewController: EditCommsViewController!
    var mockEditCommsPresenter: MockEditCommsPresenter!
    var comm: Article!

    override func setUpWithError() throws {
        mockEditCommsPresenter = MockEditCommsPresenter()
        editCommsViewController = EditCommsViewController.instantiate(storyboard: "EditComms")
        editCommsViewController.editCommsPresenter = mockEditCommsPresenter
        
        let articleToBeEdited = Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200")
        
        editCommsViewController.comm = articleToBeEdited
        
        XCTAssertNotNil(editCommsViewController.view)
    }

    override func tearDownWithError() throws {
        editCommsViewController = nil
        mockEditCommsPresenter = nil
    }

    
    func testSaveEdittedCommTapped() throws{
        editCommsViewController.saveEdittedCommTapped()
        
        // Assert
        XCTAssertEqual(1, mockEditCommsPresenter.didTapSaveComms)
    }
    
    func testSelectCategoryTapped() throws{
        editCommsViewController.selectCategoryTapped((Any).self)
        
        // Assert
        XCTAssertEqual(1, mockEditCommsPresenter.didTapSelectCategoryCount)
    }
    
    
    func testViewDidLoad() throws {
        editCommsViewController.viewDidLoad()
        
        // Assert
        XCTAssertEqual(2, mockEditCommsPresenter.didLoadCommCount) // change it later
    }
    
}

