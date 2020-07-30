//
//  ShowCategoriesPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol ShowCategoriesPresenterView {
    func errorOccured(message: String)
    func setCategories(with categories: [Category])
    func addNewCategory(with new: Category)
}

protocol ShowCategoriesPresenterDelegate {
    func didSelectCategory(with category: Category)
}

class ShowCategoriesPresenter: ShowCategoriesPresenterProtocol {
   
    var currentPage: String!
    var delegate: ShowCategoriesPresenterDelegate
    var view: ShowCategoriesPresenterView
    var apiService: ApiServiceProtocol
    var categories = [Category]()
    
    init(with view: ShowCategoriesPresenterView, delegate: ShowCategoriesPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
    }
    
    func didSelectCategory(with category: Category) {
        delegate.didSelectCategory(with: category)
    }
    
    func loadCategories() {
        getCategories()
    }
    
    func getCategories() {
        apiService.fetchData(url: "\(Constants.ApiService.url)/categories", objectType: [Category].self) { result in
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
                    self.view.setCategories(with: categories)
                    
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func addCategory(with new: AddCategory) {
        apiService.addACategory(url: "\(Constants.ApiService.url)/categories", payload: new) { (result) in
            switch result {
                case .failure(.badUrl):
                    self.view.errorOccured(message: "Given Url was bad")
                case .failure(.failedToDecode):
                    self.view.errorOccured(message: "Failed to decode data" )
                case .failure(.requestFailed):
                    self.view.errorOccured(message: "request failed")
                case .failure(.unAuthenticated):
                    self.view.errorOccured(message: "Unauthenticated" )
                case .success(let category):
                    self.view.addNewCategory(with: category)
                default:
                    self.view.errorOccured(message: "error")
            }
        }

    }

    func sendCategory(with name: AddCategory) {
         addCategory(with: name)
    }
       
       
    
    
}

