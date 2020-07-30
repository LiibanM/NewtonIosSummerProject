
//
//  EditCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation


protocol EditCommsPresenterView {
    func setCommsData(with article: Article)
    func setCategory(with category: Category)
    func errorOccured(message: String)
}

protocol EditCommsPresenterDelegate {
    func goToCommsListAfterSave()
    func goToCategoriesFromEdit(currentPage: String)
    
}

class EditCommsPresenter: EditCommsPresenterProtocol {
    
    var articleId: Int?
    var comm: Article?
    var delegate: EditCommsPresenterDelegate!
    var view: EditCommsPresenterView!
    var apiService: ApiServiceProtocol!
    
    init(with view: EditCommsPresenterView, delegate: EditCommsPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.apiService = apiService
        self.view = view
        self.delegate = delegate
    }
    
    func loadComm() {
        if let passedComm = comm {
            view.setCommsData(with: passedComm)
        } else {
            loadCommFromId()
//            fetchCommFromId()
        }
    }
        
    func selectedCategory(with category: Category) {
        view.setCategory(with: category)
    }
    
    func didTapSave(for article: Article) {
        saveEdittedPost(article)
    }
    
    func didTapSelectCategory() {
        delegate.goToCategoriesFromEdit(currentPage: "edit")
    }
    
    func saveEdittedPost(_ article: Article) {
        apiService.sendData(url: "\(Constants.ApiService.url)/articles\(articleId)", payload: article) { (result) in
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
                    self.delegate.goToCommsListAfterSave()
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func fetchCommFromId() {
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
    
    func loadCommFromId() {
      fetchCommFromId()
    }
}
    
    

