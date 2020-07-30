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
    
    func loadData() {
         getCommsDetail()
    }
    
    func getCommsDetail() {
        apiService.fetchData(url: "\(Constants.ApiService.url)/articles\(articleId)", objectType: Article.self) { (result) in
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
    
    func didTapEdit(on article: Article) {
        delegate.goToEditComms(article)
    }
    
}
