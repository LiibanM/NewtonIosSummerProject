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
    
    func testViewDidLoad() {
        // Arrange
        
        // Act
        commsListViewController.viewDidLoad()
        
        // Assert
        XCTAssertEqual(2, mockCommsListPresenter.didLoadDataCount) // change it later
    }
    
//    var didTapCategoryButtonCount = 0
//
//    func didTapCategoryButton() {
//        didTapCategoryButtonCount += 1
//
//    }
    
    func testCategroyButtonTapped() {
         // Arrange
        var didTapCategoryButtonCount = 0
        didTapCategoryButtonCount += 1

         
         // Act
        commsListViewController.categoryButtonTapped((Any).self)
         
         // Assert
        XCTAssertEqual(1, didTapCategoryButtonCount)
        
    }
     
    
    func testSetCommsData() {
        // Arrange
        let articles = [
            Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
            Article(article_id: 2, title: "New client", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
            Article(article_id: 4, title: "News", content: "This is content", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 5, title: "New covid stuff", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
            Article(article_id: 6, title: "random news", content: "This is content", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 7, title: "Not this again", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
        ]
        
        // Act
        commsListViewController.setCommsData(with: articles)
        
        // Assert
        XCTAssertEqual(articles.count, commsListViewController.comms.count)
    }
    
//    func testDidTapComm() {
//        // Arrange
//        
//        // Act
//        commsListViewController
//        
//        // Assert
//    }
    

    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
