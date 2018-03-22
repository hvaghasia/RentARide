//
//  TransitionManager.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    let presentTransitionController = PresentAnimatorController()
    let dismissTransitionController = DismissAnimatorController()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransitionController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransitionController
        
    }
}
