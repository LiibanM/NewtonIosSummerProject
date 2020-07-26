
//
//  EditCommsPresenter.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation


protocol EditCommsPresenterView {
    
}

protocol EditCommsPresenterDelegate {
    
}

class EditCommsPresenter: EditCommsPresenterProtocol {
    
    
    var delegate: EditCommsPresenterDelegate!
    var view: EditCommsPresenterView!
    
    init(with view: EditCommsPresenterView, delegate: EditCommsPresenterDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
}
