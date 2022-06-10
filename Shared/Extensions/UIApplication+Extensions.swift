//
//  UIApplication+Extensions.swift
//  TimTestVideoPlayer
//
//  Created by Timothy Adamcik on 6/10/22.
//

import UIKit

extension UIApplication {
    
    /// The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
    
    static var fli: TAApplication? {
        return UIApplication.shared.delegate as? TAApplication
    }
    
    /// Retrieves the top most, currently presented, `UIViewController`.
    /// - Parameter controller: The base `UIViewController`. Default value is `UIApplication.shared.keyWindow?.rootViewController`.
    /// - Returns: The currently presented `UIViewController` or `nil`.
    ///
    /// ````
    /// // Example
    /// let viewController = UIApplication.topViewController()
    /// ````
    ///
    /// - Note: Stack Overflow: [Get top most UIViewController](https://stackoverflow.com/a/30858591/2108547).
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        else if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        else if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }

    
    /// Replaces `UIApplication.shared.keyWindow.rootViewController` with the specified `UIViewController`.
    class func replaceRootViewController(with viewController: UIViewController, animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        guard
            let window = UIApplication.shared.keyWindowInConnectedScenes
            else {
                completion?(false)
                return
        }
        
        window.rootViewController = viewController
        
        guard animated else {
            completion?(true)
            return
        }

        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {},
                          completion: { finished in completion?(true) })
    }
    
}
