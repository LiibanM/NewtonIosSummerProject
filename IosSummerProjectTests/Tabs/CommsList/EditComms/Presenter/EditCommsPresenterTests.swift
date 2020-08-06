//
//  EditCommsPresenterTests.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 06/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import XCTest

@testable import IosSummerProject

class EditCommsPresenterTests: XCTestCase {
    
    var editCommsPresenter: EditCommsPresenter!
    var mockApiService: MockApiService!
    var mockEditCommsPresenterDelegate: MockEditCommsPresenterDelegate!
    var mockEditCommsPresenterView: MockEditCommsPresenterView!
    var mockEditCommsPresenter: MockEditCommsPresenter!

    override func setUpWithError() throws {
        mockApiService = MockApiService()
        mockEditCommsPresenterDelegate = MockEditCommsPresenterDelegate()
        mockEditCommsPresenterView = MockEditCommsPresenterView()
        mockEditCommsPresenter = MockEditCommsPresenter()
        editCommsPresenter = EditCommsPresenter(with: mockEditCommsPresenterView, delegate: mockEditCommsPresenterDelegate, mockApiService)
        
        let articleToBeEdited = Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200")
        
        editCommsPresenter.comm = articleToBeEdited
        editCommsPresenter.articleId = 1
    }

    override func tearDownWithError() throws {
        mockApiService = nil
        mockEditCommsPresenterDelegate = nil
        mockEditCommsPresenterView = nil
        mockEditCommsPresenter = nil
        editCommsPresenter = nil
    }

    func testSaveEditedPost() throws {
        let editedArticle = Article(article_id: 1, title: "Covid-19", content: "Changed content", category: Category(categoryId: 1, categoryName: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200")
        
        editCommsPresenter.saveEdittedPost(editedArticle)
        
        XCTAssertEqual(1 , editedArticle.article_id)
    }
    
    func testFetchCommFromId() throws {
        editCommsPresenter.fetchCommFromId()
        
        XCTAssertEqual(1, editCommsPresenter.comm?.article_id)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
