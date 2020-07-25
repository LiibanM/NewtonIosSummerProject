//
//  CommsPresenterProcol.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol CommsListPresenterProtocol {
    func didTapAddComms()
    func didTapComm(with id: Int)
    func didSwipeEdit(with id: Int)
    func loadData()
}
