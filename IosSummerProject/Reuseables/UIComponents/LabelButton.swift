//
//  LabelButton.swift
//  IosSummerProject
//
//  Created by Nikola Drangovski on 28/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

class LabelButton: UIButton {
 
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.layer.cornerRadius = 5
        self.isUserInteractionEnabled = false
    }
}
