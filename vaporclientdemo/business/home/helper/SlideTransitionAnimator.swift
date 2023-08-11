
import UIKit

class SlideTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let finalFrameForVC = transitionContext.finalFrame(for: toVC)
        
        if isPresenting {
            toVC.view.frame = finalFrameForVC.offsetBy(dx: toVC.view.frame.width, dy: 0)
            containerView.addSubview(toVC.view)
        }
        
        let animationFrame = isPresenting ? finalFrameForVC : fromVC.view.frame.offsetBy(dx: fromVC.view.frame.width, dy: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if self.isPresenting {
                toVC.view.frame = animationFrame
            } else {
                fromVC.view.frame = animationFrame
                let vc = toVC as! ViewController
                vc.updateUI(with: nil, isFirst: false)
            }
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.isPresenting = false
            
        }
    }
}

