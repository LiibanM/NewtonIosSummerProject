//
//  Article.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

struct Article: Codable {
    let articleID: Int
    let title: String?
    let content: String?
    let articleCategories: [ArticleCategory]
    let dateCreated: String
    let dateLastUpdated: String
    let user: User
    let highlighted: Bool
    let picture: String?
}

struct ArticleCategory: Codable {
    let category: Category
}

struct NewArticleCategory: Codable {
    let category: NewCategory
}

struct NewArticle: Codable {
//    let articleID: Int
    let title: String
    let content: String
    let articleCategories: [NewArticleCategory]
//    let dateCreated: String
//    let dateLastUpdated: String
//    let user: NewUser
    let highlighted: Bool
    let picture: String
}
