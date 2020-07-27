//
//  ShowCategoriesPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol ShowCategoriesPresenterView {
    
}

protocol ShowCategoriesPresenterDelegate {
    
}

class ShowCategoriesPresenter: ShowCategoriesPresenterProtocol {
    var delegate: ShowCategoriesPresenterDelegate
    var view: ShowCategoriesPresenterView
    
    init(with view: ShowCategoriesPresenterView, delegate: ShowCategoriesPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
    
    
}
