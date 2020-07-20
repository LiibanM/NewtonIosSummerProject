//
//  AddCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol AddCommsPresenterDelegate {
    
}

protocol AddCommsPresenterView {
    func errorOccured(message: String)
//    func loadComms()
}

class AddCommsPresenter: AddCommsPresenterProtocol {
    
    var delegate: AddCommsPresenterDelegate
    var view: AddCommsPresenterView
    
    init(with view: AddCommsPresenterView, delegate: AddCommsPresenterDelegate) {
        self.delegate = delegate
        self.view = view
    }
    
}
