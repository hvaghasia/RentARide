//
//  StoryBoard+Helper.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    public class func initialize<T>(type: T.Type, fromStoryboard storyboard: String) -> T {
        let id = String(describing: type)
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: id)
        
        return viewController as! T
    }
}
