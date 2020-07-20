//
//  StoryBoarded.swift
//  IosSummerProject
//
//  Created by Liiban Mukhtar on 16/07/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(storyboard: String) -> Self
    
}
extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboard: String = "Main") -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
