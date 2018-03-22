//
//  PresentAnimatorController.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

class PresentAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let transitionDuration: TimeInterval = 0.7
    var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        let bounds = UIScreen.main.bounds
        
        /// add graish overlay view
        let overlayView = UIView(frame: bounds)
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.2
        overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PresentAnimatorController.overlayViewTapped(_:))))
        containerView.addSubview(overlayView)
        
        let toViewControllerHeight = bounds.height * 0.4
        let finalFrameForVC = CGRect(x: 0,
                                     y: bounds.height - toViewControllerHeight,
                                     width: bounds.width,
                                     height: toViewControllerHeight)
        
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveLinear,
                       animations: {
                        toViewController.view.frame = finalFrameForVC
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
    
    // Dismiss partially presented view
    @objc func overlayViewTapped(_ tapGesture: UITapGestureRecognizer) {
        if let context = transitionContext {
            guard let toViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
            
            toViewController.dismiss(animated: true, completion: nil)
        }
    }
}
