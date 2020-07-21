//
//  CommsPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsListPresenterDelegate {
    func goToCreateContent()
}

protocol CommsListPresenterView {
    func errorOccured(message: String)
    func setCommsData(with data: [Article])
//    func loadComms()
}

class CommsListPresenter: CommsListPresenterProtocol {
    
    var delegate: CommsListPresenterDelegate
    var view: CommsListPresenterView
    var apiService: ApiServiceProtocol
    
    init(with view: CommsListPresenterView, delegate: CommsListPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
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
                    self.view.setCommsData(with: articles)
                    print("Success")
                default:
                    self.view.errorOccured(message: "error")
            }
        }
    }
    
    func didTapAddComms() {
        delegate.goToCreateContent()
    }
    
    
    
}
