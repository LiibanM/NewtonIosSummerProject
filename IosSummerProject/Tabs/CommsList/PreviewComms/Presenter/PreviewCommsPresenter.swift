//
//  PreviewCommsPresenter.swift
//  IosSummerProject
//
//  Created by Bradley Burgess on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol PreviewCommsPresenterView {
    func setCommsData(with article: Article)
}

protocol PreviewCommsPresenterDelegate {
}

class PreviewCommsPresenter: PreviewCommsPresenterProtocol {
    
    var comm: Article!
    var delegate: PreviewCommsPresenterDelegate
    var view: PreviewCommsPresenterView
    var apiService: ApiServiceProtocol
    
    init(with view: PreviewCommsPresenterView, delegate: PreviewCommsPresenterDelegate, _ apiService: ApiServiceProtocol) {
        self.delegate = delegate
        self.view = view
        self.apiService = apiService
    }
    
    func loadComm() {
        view.setCommsData(with: comm)
    }

}
