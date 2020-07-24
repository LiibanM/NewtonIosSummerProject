//
//  AddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsPresenterDelegate {
    
}

protocol CommsPresenterView {
    func errorOccured(message: String)
//    func loadComms()
}

class CommsPresenter: CommsPresenterProtocol {
    
    var delegate: CommsPresenterDelegate
    var view: CommsPresenterView
    
    init(with view: CommsPresenterView, delegate: CommsPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
}
