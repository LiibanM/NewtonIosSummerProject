//
//  MockCommsListPresenterDelegate.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

@testable import IosSummerProject

class MockCommsListPresenterDelegate: CommsListPresenterDelegate {
    
    var didGoToCreateContentCallCount = 0
    var didGoToCommsDetailCallCount = 0
    var didGoToEditCommsCallCount = 0
    
    func goToCreateContent() {
        didGoToCreateContentCallCount += 1
    }
    
    func goToCommsDetail(_ id: Int) {
        didGoToCommsDetailCallCount += 1
    }
    
    func goToEditComms(_ id: Int) {
        didGoToEditCommsCallCount += 1
    }
    
    func getCommsDetail(with id: Int) -> UIViewController {
        return UIViewController()
    }
    
    
}
