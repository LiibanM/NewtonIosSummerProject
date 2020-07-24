//
//  AddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsDetailPresenterDelegate {
    
}

protocol CommsDetailPresenterView {
    func setCommsData(with data: Article)
}

class CommsDetailPresenter: CommsDetailPresenterProtocol {
    
    var article_id:Int!
    
    var delegate: CommsDetailPresenterDelegate
    var view: CommsDetailPresenterView
    
    init(with view: CommsDetailPresenterView, delegate: CommsDetailPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
    func loadData() {
            let articles = [
                Article(article_id: 1, title: "Covid-19", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceNow: 86400), highlighted: true, image: "https://i2.wp.com/neurosciencenews.com/files/2020/06/27-biomarkers-covid19-nuroscienrw-public.jpg?fit=1400%2C933&ssl=1"),
                Article(article_id: 2, title: "New client", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: false, image: "https://picsum.photos/200"),
                Article(article_id: 3, title: "Tech news", content: "This is content", category: Category(category_id: 1, category_name: "Tech") , date: Date(timeIntervalSinceReferenceDate: 67893), highlighted: true, image: "https://picsum.photos/200"),
                Article(article_id: 4, title: "News", content: "This is content", category: Category(category_id: 1, category_name: "News") , date: Date(timeIntervalSinceReferenceDate: 86400), highlighted: false, image: "https://picsum.photos/200"),
                Article(article_id: 5, title: "New covid stuff", content: "This is content", category: Category(category_id: 1, category_name: "COVID-19") , date: Date(timeIntervalSinceReferenceDate: 67833), highlighted: true, image: "https://picsum.photos/200"),
                Article(article_id: 6, title: "random news", content: "This is content", category: Category(category_id: 1, category_name: "Random") , date: Date(timeIntervalSinceReferenceDate: 90000), highlighted: false, image: "https://picsum.photos/200"),
                Article(article_id: 7, title: "Not this again", content: "This is content", category: Category(category_id: 1, category_name: "Business Updates") , date: Date(), highlighted: false, image: "https://picsum.photos/200")
            ]
            view.setCommsData(with: articles[article_id-1])
          }
    
}
