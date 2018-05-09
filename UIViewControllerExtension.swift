//
//  UIViewControllerExtension.swift
//  pagerTest
//
//  Created by Albin CR on 5/3/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

public extension UIViewController {
    func addViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            addChildViewController(viewController)
            view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    func removeViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
    }
}
