//
//  mockCommsListPresenterDelegate.swift
//  IosSummerProjectTests
//
//  Created by Sheikh Ahmad on 23/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
@testable import IosSummerProject


class MockCommsListPresenterDelegate: CommsListPresenterDelegate {
    
    var didGoToCreateContentCallCount = 0
    var didGoToCommsDetailCallCount = 0

    
    func goToCreateContent() {
        didGoToCreateContentCallCount += 1
    }
    
    func goToCommsDetail(_ id: Int) {
        didGoToCommsDetailCallCount += 1
    }

    
    
}
