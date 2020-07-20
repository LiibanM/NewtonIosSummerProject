//
//  CommsPresenter.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsListPresenterDelegate {
    
}

protocol CommsListPresenterView {
    func errorOccured(message: String)
//    func loadComms()
}

class CommsListPresenter: CommsListPresenterProtocol {
    
    var delegate: CommsListPresenterDelegate
    var view: CommsListPresenterView
    
    init(with view: CommsListPresenterView, delegate: CommsListPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
}
