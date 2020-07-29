//
//  AddCommsPresenterProtocol.swift
//  IosSummerProject
//
//  Created by Akash Mair on 18/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol AddCommsPresenterProtocol {
    func didTapPost()
    func didTapSelectCategory()
    func selectedCategory(_ category: Category)
}
