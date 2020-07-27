//
//  AddTagPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol AddTagPresenterView {
    
}

protocol AddTagPresenterDelegate {
    
}

class AddTagPresenter: AddTagPresenterProtocol {
    
    var delegate: AddTagPresenterDelegate
    var view: AddTagPresenterView
    
    init(with view: AddTagPresenterView, delegate: AddTagPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
    func getCategories() {
        
        
    }
}
