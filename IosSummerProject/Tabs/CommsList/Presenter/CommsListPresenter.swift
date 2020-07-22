//
//  CommsPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsListPresenterDelegate {
    func goToCreateContent()
}

protocol CommsListPresenterView {
    func errorOccured(message: String)
    func setCommsData(with data: [Article])
//    func loadComms()
}

class CommsListPresenter: CommsListPresenterProtocol {
    
    var delegate: CommsListPresenterDelegate
    var view: CommsListPresenterView
    var apiService: ApiServiceProtocol
    
    init(with view: CommsListPresenterView, delegate: CommsListPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
    }
    
    func getComms() {
        apiService.fetchData(url: "https://www.google.com", objectType: [Article].self) { (result) in
            switch result {
                case .failure(.badUrl):
                    self.view.errorOccured(message: "Given Url was bad")
                case .failure(.failedToDecode):
                    self.view.errorOccured(message: "Failed to decode data" )
                case .failure(.requestFailed):
                    self.view.errorOccured(message: "request failed")
                case .failure(.unAuthenticated):
                    self.view.errorOccured(message: "Unauthenticated" )
                case .success(let articles):
                    let sortedArticles = self.sortByHighlighted(data: articles)
                    self.view.setCommsData(with: sortedArticles)
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func didTapAddComms() {
        delegate.goToCreateContent()
    }
    
    func loadData() {
//          getComms()
        let articles = [
            Article(title: "First post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
            Article(title: "Second post", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
        ]
        
        let sortedByDate = self.sortByDate(data: articles)
        let sortedArticles = self.sortByHighlighted(data: sortedByDate)
        
        view.setCommsData(with: sortedArticles)
      }
    
    func sortByHighlighted(data: [Article]) -> [Article] {
        return data.sorted { $0.highlighted && !$1.highlighted }
    }
    
    func sortByDate(data: [Article]) -> [Article] {
        return data.sorted { $0.date > $1.date }
    }
    
}
