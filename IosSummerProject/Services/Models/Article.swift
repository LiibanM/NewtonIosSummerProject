//
//  Article.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

struct Article: Codable {
//    let article_id: Int
    let title: String
    let content: String
    let category: Category
//    let date: Date
//    let user: User
//    let highlighted: Bool
    let image: String
}
