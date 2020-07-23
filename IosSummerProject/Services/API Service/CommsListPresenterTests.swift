//
//  CommsListPresenterTests.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 23/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject


class CommsListPresenterTests: XCTestCase {
    var mockCommsListPresenter: MockCommsListPresenter!
    var commsListViewController: CommsListViewController!



    override func setUpWithError() throws {
        mockCommsListPresenter = MockCommsListPresenter.init()
        
    }

    override func tearDownWithError() throws {
        mockCommsListPresenter = nil
    }

//    func testSortByHighligted() throws {
//        // Arrange
//        let articles = [
//            Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
//            Article(article_id: 2, title: "New client", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
//            Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
//            Article(article_id: 4, title: "News", content: "This is content", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
//            Article(article_id: 5, title: "New covid stuff", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
//            Article(article_id: 6, title: "random news", content: "This is content", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
//            Article(article_id: 7, title: "Not this again", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
//        ]
//        
//        // Act
////        CommsListPresenter.sortByHighlighted()
//        
//        
//
//        
//        
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
