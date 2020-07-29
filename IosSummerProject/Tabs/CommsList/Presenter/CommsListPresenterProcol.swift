//
//  CommsPresenterProcol.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

protocol CommsListPresenterProtocol {
    func didTapAddComms()
    func didTapComm(with id: Int)
    func didSwipeEdit(with id: Int)
    func highlightComm(with id: Int)
    func loadData()
    func previewCommsDetail(with id: Int) -> UIViewController
}

