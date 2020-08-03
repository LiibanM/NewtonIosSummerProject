//
//  MockEditCommsPresenterDelegate.swift
//  IosSummerProjectTests
//
//  Created by fstoqnov on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

@testable import IosSummerProject

class MockEditCommsPresenterDelegate: EditCommsPresenterDelegate {
    
    var didGoToCommsListAfterSave = 0
    
    func goToCommsListAfterSave() {
        didGoToCommsListAfterSave += 1
    }
}
