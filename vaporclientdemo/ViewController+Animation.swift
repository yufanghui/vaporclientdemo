//
//  ViewController+Animation.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit
extension ViewController: UIViewControllerTransitioningDelegate {

    @objc func handleSwipeLeftGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            let settingVc = SettingViewController()
            settingVc.transitioningDelegate = self
            settingVc.modalPresentationStyle = .overCurrentContext // 这样A页面会保持在B页面的下面
            slideTransitionAnimator.isPresenting = true
            present(settingVc, animated: true, completion: nil)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideTransitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideTransitionAnimator
    }
}

