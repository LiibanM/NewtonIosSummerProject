//
//  User.swift
//  IosSummerProject
//
//  Created by Sheikh Ahmad on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

struct User: Codable {
    let user_id: Int
    let first_name: String
    let last_name: String
    let email_address: String
    let picture: String
    let permission_level: String?
}
