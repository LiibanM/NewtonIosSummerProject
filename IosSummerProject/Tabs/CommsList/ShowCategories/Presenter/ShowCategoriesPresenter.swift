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
    func didSelectCategory(with category: Category)
}

class ShowCategoriesPresenter: ShowCategoriesPresenterProtocol {
   
    var currentPage: String! // Should be optional
    var delegate: ShowCategoriesPresenterDelegate // Let not var
    var view: ShowCategoriesPresenterView // Let not var
    var apiService: ApiServiceProtocol // Let not var
    var categories = [Category]()
    
    init(with view: ShowCategoriesPresenterView, delegate: ShowCategoriesPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
        self.categories = [
            Category(categoryId: 1, categoryName: "abc"),
            Category(categoryId: 2, categoryName: "3245353453453534"),
            Category(categoryId: 3, categoryName: "456"),
            Category(categoryId: 4, categoryName: "879")
        ]
    }
    
    func didSelectCategory(with category: Category) {
        delegate.didSelectCategory(with: category)
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
    
//    func sendCategory(with new: Category) {
//        apiService.sendData(url: "", payload: new) { (result) in
//            switch result {
//                case .failure(.badUrl):
//                    self.view.errorOccured(message: "Given Url was bad")
//                case .failure(.failedToDecode):
//                    self.view.errorOccured(message: "Failed to decode data" )
//                case .failure(.requestFailed):
//                    self.view.errorOccured(message: "request failed")
//                case .failure(.unAuthenticated):
//                    self.view.errorOccured(message: "Unauthenticated" )
//                case .success(let newCategory):
//                    self.view.setCategories(with: newCategory)
//                default:
//                    self.view.errorOccured(message: "error")
//            }
//        }
//    }

    func mockSendCategory(with new: Category) {
        categories.append(new)
        self.view.setCategories(with: categories)
    }

    func mockDataCategories() {
        self.view.setCategories(with: categories)
    }
    
    func sendCategory(with category: Category) {
        mockSendCategory(with: category)
    }
       
       
    
    
}

