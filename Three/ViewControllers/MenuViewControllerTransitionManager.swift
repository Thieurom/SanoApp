//
//  MenuViewControllerTransitionManager.swift
//  Three
//
//  Created by Doan Le Thieu on 8/28/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    private var isPresenting: Bool = true
    
    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let viewController = isPresenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)
        
        guard let menuViewController = viewController as? MenuViewController else {
            return
        }
        
        // if MenuViewController object is being presented, we need to add its view to
        // transitionContext's containerView, otherwise it's been added automatically
        // and we also need to move it off screen to prepare the move-in animation
        if isPresenting {
            let containerView = transitionContext.containerView
            containerView.addSubview(menuViewController.view)
            moveOff(menuViewController: menuViewController)
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            if self.isPresenting {
                self.moveIn(menuViewController: menuViewController)
            } else {
                self.moveOff(menuViewController: menuViewController)
            }
        }, completion: { (_) in
            transitionContext.completeTransition(true)
        })
    }
    
    private func moveIn(menuViewController: MenuViewController) {
        menuViewController.view.alpha = 1
        menuViewController.menuView.transform = .identity
    }
    
    private func moveOff(menuViewController: MenuViewController) {
        menuViewController.view.alpha = 0
        
        let menuViewHeight: CGFloat = 152
        menuViewController.menuView.transform = CGAffineTransform(translationX: 0, y: menuViewHeight)
    }
}
