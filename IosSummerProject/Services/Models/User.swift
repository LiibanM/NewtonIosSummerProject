//
//  User.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

struct User: Codable {
    let userID: Int
    let firstName: String
    let lastName: String
    let emailAddress: String
    let picture: String
    var permissionLevel: String?
}
