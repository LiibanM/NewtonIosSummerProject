//
//  AddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsDetailPresenterDelegate {
    func goToEditComms(_ article: Article) 
}

protocol CommsDetailPresenterView {
    func setCommsData(with data: Article)
    func errorOccured(message: String)
}

class CommsDetailPresenter: CommsDetailPresenterProtocol {
    
    var articleId: Int!
    
    var delegate: CommsDetailPresenterDelegate
    var view: CommsDetailPresenterView
    var apiService: ApiServiceProtocol
    var user: User
    
    init(with view: CommsDetailPresenterView, delegate: CommsDetailPresenterDelegate, _ user: User, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
        self.user = user
    }
    
    func getCommsDetail() {
           apiService.fetchData(url: "https://www.google.com\(articleId)", objectType: Article.self) { (result) in
               switch result {
                   case .failure(.badUrl):
                       self.view.errorOccured(message: "Given Url was bad")
                   case .failure(.failedToDecode):
                       self.view.errorOccured(message: "Failed to decode data" )
                   case .failure(.requestFailed):
                       self.view.errorOccured(message: "request failed")
                   case .failure(.unAuthenticated):
                       self.view.errorOccured(message: "Unauthenticated" )
                   case .success(let article):
                       self.view.setCommsData(with: article)
                       print("Success")
                   default:
                       self.view.errorOccured(message: "error")
               }
           }
       }
    
    func loadData() {
            let articles = [
                Article(article_id: 1, title: "Covid-19", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://i2.wp.com/neurosciencenews.com/files/2020/06/27-biomarkers-covid19-nuroscienrw-public.jpg?fit=1400%2C933&ssl=1"),
                Article(article_id: 2, title: "New client", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://www.itarian.com/assets-new/images/client-portal.png"),
                Article(article_id: 3, title: "Tech news", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://i2-prod.manchestereveningnews.co.uk/incoming/article14379834.ece/ALTERNATES/s615/050318_LRR_MEN_WomenTech.jpg"),
                Article(article_id: 4, title: "News", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://i2-prod.cambridge-news.co.uk/incoming/article17510071.ece/ALTERNATES/s615/1_Breaking-News.jpg"),
                Article(article_id: 5, title: "New covid stuff", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://www.eurocockpit.be/sites/default/files/2020-03/covid-19-2-800x500-1.jpg"),
                Article(article_id: 6, title: "random news", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://ichef.bbci.co.uk/news/410/cpsprodpb/3045/production/_113475321_india_covid_one_million-nc.png"),
                Article(article_id: 7, title: "Not this again", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non risus sed mauris maximus semper. Nulla auctor consequat ligula, et feugiat nibh imperdiet in. Nunc id lectus ut ligula pharetra iaculis ac in ex. Nullam vestibulum et erat vel efficitur. Nunc et purus diam. Proin scelerisque odio a vulputate dictum. Curabitur luctus nisi elementum condimentum pellentesque. Morbi hendrerit nulla dolor, sed facilisis velit vestibulum non. Donec lacinia sodales justo, et varius dolor ullamcorper ut. Duis malesuada lacus nec velit finibus, id facilisis nisi tincidunt. Donec molestie sem aliquam tristique viverra. Aenean in quam ultrices, viverra urna eu, euismod quam. Fusce vel lacus iaculis, dictum arcu eu, volutpat lectus. Proin interdum, nibh sed molestie vulputate, est ipsum iaculis neque, dignissim volutpat nisl ligula vel nunc.\n\nFusce iaculis neque id dui sollicitudin, vitae mattis tellus sagittis. Donec porta laoreet dolor a bibendum. Suspendisse potenti. Curabitur venenatis porttitor elit sit amet pulvinar. Etiam ligula augue, consequat non suscipit non, vulputate et dolor.", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://lh3.googleusercontent.com/proxy/nXBjwaI_tyEYVUCyxfai4C3aBMRQxgvZJVh-wZaDZ_nEFK8xeHkDa5LwNAzyXiirLK3HBZFb6_fuqyRDzlWpDazJanVJ4Onf6K3asycDj2SqqD3BJv8HiysYpYSh21-2VXwvTucczF-c-WGGH1rcJQkkuEN2_yJhFQU")
            ]
        let article = articles.filter {
            $0.article_id == articleId
        }[0]
            view.setCommsData(with: article)
          }
    
    func didTapEdit(on article: Article) {
        delegate.goToEditComms(article)
    }
    
}
