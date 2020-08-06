//
//  CommsListPresenterTests.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest
@testable import IosSummerProject


class CommsListPresenterTests: XCTestCase {
    
    var commsListPresenter: CommsListPresenter!
    var mockApiService: MockApiService!
    var mockCommsListPresenterDelegate: MockCommsListPresenterDelegate!
    var mockCommsListPresenterView: MockCommsListPresenterView!

    override func setUpWithError() throws {
        mockApiService = MockApiService()
        mockCommsListPresenterDelegate = MockCommsListPresenterDelegate()
        mockCommsListPresenterView = MockCommsListPresenterView()
        commsListPresenter = CommsListPresenter(with: mockCommsListPresenterView, delegate: mockCommsListPresenterDelegate, mockApiService)
    }

    override func tearDownWithError() throws {
        commsListPresenter = nil
        mockApiService = nil
        mockCommsListPresenterDelegate = nil
        mockCommsListPresenterView = nil
    }

    func testSortByHighligted() throws {
        
      // Arrange
      let articles = [
        Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
        Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(categoryId: 1, categoryName: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200")
      ]
      let sortedArticles = [
        Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
        Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(categoryId: 1, categoryName: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200")
      ]
        
      // Act
      let result = commsListPresenter.sortByHighlighted(data: articles)
        
      // Assert
      XCTAssertEqual(result[0].title, sortedArticles[0].title)
      XCTAssertEqual(result[1].title, sortedArticles[1].title)
      XCTAssertEqual(result[2].title, sortedArticles[2].title)
    }
    
    func testSortByDate() throws {
        
      // Arrange
      let articles = [
        Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67860), highlighted: false, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200")
      ]
      let sortedArticles = [
        Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
        Article(article_id: 2, title: "New client", content: "This is content", category: Category(categoryId: 1, categoryName: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67860), highlighted: false, image: "https://picsum.photos/200")
      ]
        
      // Act
      let result = commsListPresenter.sortByDate(data: articles)
        
      // Assert
      XCTAssertEqual(result[0].title, sortedArticles[0].title)
      XCTAssertEqual(result[1].title, sortedArticles[1].title)
      XCTAssertEqual(result[2].title, sortedArticles[2].title)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
