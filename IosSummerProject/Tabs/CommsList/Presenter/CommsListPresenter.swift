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
    func goToCommsDetail(_ id: Int)
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
    
    func didTapComm(with id: Int) {
        delegate.goToCommsDetail(id)
    }
    
    func loadData() {
//          getComms() - need to replace when backend is ready
        let articles = [
            Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://i2.wp.com/neurosciencenews.com/files/2020/06/27-biomarkers-covid19-nuroscienrw-public.jpg?fit=1400%2C933&ssl=1"),
            Article(article_id: 2, title: "New client", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
            Article(article_id: 4, title: "News", content: "This is content", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 5, title: "New covid stuff", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
            Article(article_id: 6, title: "random news", content: "This is content", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
            Article(article_id: 7, title: "Not this again", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
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
