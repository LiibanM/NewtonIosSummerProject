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
    var user: NewUser
    
    init(with view: CommsListPresenterView, delegate: CommsListPresenterDelegate, _ user: NewUser, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
        self.user = user
    }
    
    func loadData() {
        getComms()
        getCategories()
    }
    
    func getComms() {
        apiService.fetchData(url: "\(Constants.ApiService.url)/Articles", objectType: [Article].self) { (result) in
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
//                    let sortedByDate = self.sortByDate(data: articles)
//                    let sortedArticles = self.sortByHighlighted(data: sortedByDate)
                    print(articles)
                    self.view.setCommsData(with: articles)
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func getCategories() {
        apiService.fetchData(url: "\(Constants.ApiService.url)/Categories", objectType: [Category].self) { (result) in
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
                    let categoryNames = categories.compactMap { $0.categoryName }
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
    
    func sortByHighlighted(data: [Article]) -> [Article] {
        return data.sorted { $0.highlighted && !$1.highlighted }
    }
    
    func sortByDate(data: [Article]) -> [Article] {
        return data.sorted { $0.dateCreated > $1.dateCreated }
    }
    
}
