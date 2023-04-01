//
//  ViewControllerContainable.swift
//  Mercaux
//
//  Created by Alexey Ivanov on 18.12.2020.
//  Copyright © 2020 Denis Mukha. All rights reserved.
//

import UIKit

protocol ViewControllerContainable {
    var containerView: UIView {get}
    
    func present(viewController:UIViewController,
                 animated:Bool,
                 duration:TimeInterval,
                 delay: TimeInterval)
    
    func dismiss(viewController:UIViewController,
                 animated:Bool,
                 duration: TimeInterval,
                 delay: TimeInterval)
}

extension ViewControllerContainable where Self: UIViewController {
    func present(viewController: UIViewController, animated: Bool, duration: TimeInterval, delay: TimeInterval) {
        guard let newView = viewController.view else { return }
        newView.translatesAutoresizingMaskIntoConstraints = false
        let oldViewController = children.last
        
        guard animated else {
            if let oldvc = oldViewController {
                dismiss(viewController: oldvc, animated: false, duration: 0.0, delay: 0.0)
            }
            
            addChild(viewController)
            containerView.addSubview(newView)
            viewController.didMove(toParent: self)
            newView.addConstraintsFor(containerView: containerView, with: .zero)
            return
        }
        
        //animated
        oldViewController?.willMove(toParent: nil)
        
        addChild(viewController)
        containerView.addSubview(newView)
        newView.addConstraintsFor(containerView: containerView, with: .zero)
        
        viewController.view.alpha = 0
        viewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
                        viewController.view.alpha = 1
                        oldViewController?.view.alpha = 0
        }) { (finished) in
            oldViewController?.view.removeFromSuperview()
            oldViewController?.removeFromParent()
            viewController.didMove(toParent: self)
        }
    }
    
    func dismiss(viewController: UIViewController, animated: Bool, duration: TimeInterval, delay: TimeInterval) {
        viewController.willMove(toParent: nil)
        
        guard animated else {
            viewController.removeFromParent()
            viewController.view.removeFromSuperview()
            viewController.didMove(toParent: nil)
            return
        }
        UIView.animate(withDuration: duration, delay: delay, options: .transitionCrossDissolve, animations: {
            viewController.view.alpha = 0.0
        }) { (finished) in
            self.dismiss(viewController: viewController,
                         animated: false,
                         duration: 0.0,
                         delay: 0.0)
        }
    }
}


extension UIView {
    func addConstraintsFor(containerView: UIView, with insets: UIEdgeInsets) {
        let metrics = ["top": insets.top,
                       "left" : insets.left,
                       "bottom" : insets.bottom,
                       "right" : insets.right]
        
        let views = ["view": self]
        containerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|",
                                           options: [],
                                           metrics: metrics,
                                           views: views)
        )
        containerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|",
                                           options: [],
                                           metrics: metrics,
                                           views: views)
        )
    }
}
