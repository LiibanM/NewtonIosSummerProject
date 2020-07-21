//
//  ComsContent.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 20/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation

struct CommsContent: Codable {
  var image: Data?
  var title: String
  var description: String
  init(image: Data, title: String, description: String) {
    self.image = image
    self.title = title
    self.description = description
  }
}
