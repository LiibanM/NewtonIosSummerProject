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
}

protocol ShowCategoriesPresenterDelegate {
    
}

class ShowCategoriesPresenter: ShowCategoriesPresenterProtocol {
    var delegate: ShowCategoriesPresenterDelegate
    var view: ShowCategoriesPresenterView
    var apiService: ApiServiceProtocol
    
    init(with view: ShowCategoriesPresenterView, delegate: ShowCategoriesPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
    }
    
    func loadCategories() {
        mockDataCategories()
    }
    
    func getCategories() {
        
        apiService.fetchData(url: "", objectType: [Category].self) { result in
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
    
    func mockDataCategories() {
        let categories = [Category(category_id: 1, category_name: "abc"), Category(category_id: 2, category_name: "123"), Category(category_id: 3, category_name: "456"), Category(category_id: 4, category_name: "879")]
        
        self.view.setCategories(with: categories)
    }
    
    
}

