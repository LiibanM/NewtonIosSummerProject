//
//  EditCommsPresenterProtocol.swift
//  IosSummerProject
//
//  Created by Akash Mair on 26/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation


protocol EditCommsPresenterProtocol {
    func loadComm()
    func didTapSave(for article: Article)
    func didTapSelectCategory()
    func didTapPreviewComms(on article: Article)
    func selectedCategory(with category: Category)
    func checkForChanges(oldComm: Article, editedComm: Article) -> Bool
}
