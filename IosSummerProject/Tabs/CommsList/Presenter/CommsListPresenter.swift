//
//  CommsPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

protocol CommsListPresenterDelegate {
    func goToCreateContent()
    func goToCommsDetail(_ id: Int)
    func goToEditComms(_ id: Int)
    func getCommsDetail(with id: Int) -> UIViewController

}

protocol CommsListPresenterView {
    func errorOccured(message: String)
    func setCommsData(with data: [Article])
    func setAllCategories(with data: [String])
}

class CommsListPresenter: CommsListPresenterProtocol {
    
    func previewCommsDetail(with id: Int) -> UIViewController {
        return delegate.getCommsDetail(with: id)
    }
    

    var delegate: CommsListPresenterDelegate
    var view: CommsListPresenterView
    var apiService: ApiServiceProtocol
    var user: User
    
    init(with view: CommsListPresenterView, delegate: CommsListPresenterDelegate, _ user: User, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
        self.user = user
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
    
    func getCategories() {
        apiService.fetchData(url: "https://www.google.com", objectType: [Category].self) { (result) in
            switch result {
                case .failure(.badUrl):
                    self.view.errorOccured(message: "Given Url was bad")
                case .failure(.failedToDecode):
                    self.view.errorOccured(message: "Failed to decode data" )
                case .failure(.requestFailed):
                    self.view.errorOccured(message: "request failed")
                case .failure(.unAuthenticated):
                    self.view.errorOccured(message: "Unauthenticated" )
                case .success(let categories):
                    let categoryNames = categories.map { $0.category_name }
                    self.view.setAllCategories(with: categoryNames)
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func highlightComm() {
        
    }
    
    func didTapAddComms() {
        delegate.goToCreateContent()
    }
    
    func didTapComm(with id: Int) {
        delegate.goToCommsDetail(id)
    }
    
    func didSwipeEdit(with id: Int) {
        delegate.goToEditComms(id)
    }
    
    func highlightComm(with id: Int) {
        
    }
    
    
    
    func loadData() {
//          getComms() - need to replace when backend is ready
        let articles = [
            Article(article_id: 1, title: "Covid-19", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://i2.wp.com/neurosciencenews.com/files/2020/06/27-biomarkers-covid19-nuroscienrw-public.jpg?fit=1400%2C933&ssl=1"),
            Article(article_id: 2, title: "New client", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://www.itarian.com/assets-new/images/client-portal.png"),
            Article(article_id: 3, title: "Tech news", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://i2-prod.manchestereveningnews.co.uk/incoming/article14379834.ece/ALTERNATES/s615/050318_LRR_MEN_WomenTech.jpg"),
            Article(article_id: 4, title: "News", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://i2-prod.cambridge-news.co.uk/incoming/article17510071.ece/ALTERNATES/s615/1_Breaking-News.jpg"),
            Article(article_id: 5, title: "New covid stuff", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://www.eurocockpit.be/sites/default/files/2020-03/covid-19-2-800x500-1.jpg"),
            Article(article_id: 6, title: "random news", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://ichef.bbci.co.uk/news/410/cpsprodpb/3045/production/_113475321_india_covid_one_million-nc.png"),
            Article(article_id: 7, title: "Not this again", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://lh3.googleusercontent.com/proxy/nXBjwaI_tyEYVUCyxfai4C3aBMRQxgvZJVh-wZaDZ_nEFK8xeHkDa5LwNAzyXiirLK3HBZFb6_fuqyRDzlWpDazJanVJ4Onf6K3asycDj2SqqD3BJv8HiysYpYSh21-2VXwvTucczF-c-WGGH1rcJQkkuEN2_yJhFQU")
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
