//
//  NavigationControllerDelegate.swift
//  CircleTransition
//
//  Created by Ziyang Tan on 12/5/14.
//  Copyright (c) 2014 Ziyang Tan. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    @IBOutlet weak var navigationController: UINavigationController?
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var panGesture = UIPanGestureRecognizer(target: self, action: Selector("panned:"))
        self.navigationController!.view.addGestureRecognizer(panGesture)
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimator()
    }
    
    @IBAction func panned(gestureRecongnizer: UIPanGestureRecognizer) {
        switch gestureRecongnizer.state {
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            if self.navigationController?.viewControllers.count > 1 {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                self.navigationController?.topViewController.performSegueWithIdentifier("PushSegue", sender: nil)
            }
            
        case .Changed:
            var translation = gestureRecongnizer.translationInView(self.navigationController!.view)
            var completionProgress = translation.x/CGRectGetWidth(self.navigationController!.view.bounds)
            self.interactionController?.updateInteractiveTransition(completionProgress)
            
        case .Ended:
            if (gestureRecongnizer.velocityInView(self.navigationController!.view).x > 0) {
                self.interactionController?.finishInteractiveTransition()
            } else {
                self.interactionController?.cancelInteractiveTransition()
            }
            self.interactionController = nil
            
        default:
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
    }
}
