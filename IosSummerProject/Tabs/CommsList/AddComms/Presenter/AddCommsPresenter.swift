//
//  AddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol AddCommsPresenterDelegate {
    func goToCommsList()
    func goToShowCategories(currentPage: String)
}

protocol AddCommsPresenterView {
    func errorOccured(message: String)
    func updateCategory(with new: Category)
//    func loadComms()
}

class AddCommsPresenter: AddCommsPresenterProtocol {
    
    var delegate: AddCommsPresenterDelegate
    var view: AddCommsPresenterView
    var apiService: ApiServiceProtocol
    
    init(with view: AddCommsPresenterView, delegate: AddCommsPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
    }
    
    func saveNewComm(article: NewArticle) {
        apiService.addNewArticle(url: "\(Constants.ApiService.url)/articles", payload: article) { result in
             switch result {
                case .failure(.badUrl):
                    self.view.errorOccured(message: "Given Url was bad")
                case .failure(.failedToDecode):
                    self.view.errorOccured(message: "Failed to decode data" )
                case .failure(.requestFailed):
                    self.view.errorOccured(message: "request failed")
                case .failure(.unAuthenticated):
                    self.view.errorOccured(message: "Unauthenticated" )
                case .success(let article ):
                    self.delegate.goToCommsList()
                    return
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }

    func didTapPost() {
        delegate.goToCommsList()
    }
    
    func didTapSelectCategory() {
        delegate.goToShowCategories(currentPage: "add")
    }
    
    func selectedCategory(_ category: Category) {
        view.updateCategory(with: category)
    }
    
}
