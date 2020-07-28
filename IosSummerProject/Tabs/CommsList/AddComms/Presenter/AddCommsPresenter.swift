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
    func goToShowCategories()
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
    
//    func sendNewComm() {
//        apiService.sendData(url: "", payload: <#T##Decodable & Encodable#>, completion: <#T##(Result<Decodable & Encodable, NetworkError>) -> ()#>)
//    }
//    
    func didTapPost() {
        delegate.goToCommsList()
    }
    
    func didTapSelectCategory() {
        delegate.goToShowCategories()
    }
    
    func selectedCategory(_ category: Category) {
        view.updateCategory(with: category)
    }
    
}
