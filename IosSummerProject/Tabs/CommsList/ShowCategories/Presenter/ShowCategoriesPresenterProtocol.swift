//
//  ShowCategoriesPresenterProtocol.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 27/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

protocol ShowCategoriesPresenterProtocol  {
    func loadCategories()
    func didSelectCategory(with category: Category)
    func sendCategory(with category: Category)
    func checkIfCategoryFieldIsEmpty(with categoryName: String) -> Bool
}
