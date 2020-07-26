//
//  MockCommsListPresenter.swift
//  IosSummerProjectTests
//
//  Created by Akash Mair on 22/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject

class MockCommsListPresenter: CommsListPresenterProtocol {
    func didSwipeEdit(with id: Int) {
        
    }
    
   
    
    var didTapAddCommsCount = 0
    var didLoadDataCount = 0
    var didTapComm = 0
    
    
    
    func didTapAddComms() {
        didTapAddCommsCount += 1
    }
    
    
    func loadData() {
        didLoadDataCount += 1
    }
    
    func didTapComm(with id: Int) {
        didTapComm += 1
    }
}
