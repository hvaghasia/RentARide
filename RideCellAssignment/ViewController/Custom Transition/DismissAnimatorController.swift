//
//  DismissAnimatorController.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

class DismissAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let transitionDuration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let bounds = UIScreen.main.bounds
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        toViewController.view.alpha = 1.0
                        fromViewController.view.frame = fromViewController.view.frame.offsetBy(dx: 0, dy: bounds.height)
                        
        }) { success in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
