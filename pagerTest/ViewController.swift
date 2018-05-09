//
//  ViewController.swift
//  pagerTest
//
//  Created by Albin CR on 5/3/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    private func newColoredViewController(color: UIColor) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor =  color.withAlphaComponent(0.2)
        return viewController
    }
    
    let t = UITableView()
    
    
    var tabPagerController:TabPagerController = {
        let tabPager = TabPagerController()
        tabPager.translatesAutoresizingMaskIntoConstraints = false
        return tabPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabPagerController)
        //        NSLayoutConstraint.activate([
        //            tabPagerController.topAnchor.constraint(equalTo: view.topAnchor),
        //            tabPagerController.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        //            tabPagerController.leftAnchor.constraint(equalTo: view.leftAnchor),
        //            tabPagerController.rightAnchor.constraint(equalTo: view.rightAnchor)
        //            ])
        
        tabPagerController.fillSuperview()
        tabPagerController.delegate = self
        tabPagerController.dataSource = self
        
    }
    
    
    
}

extension ViewController:TabPagerDataSource{
    
    func initialPagerIndex(for TabPagerController: TabPagerController) -> Int {
        return 1
    }
    
    func setPagerControllers(for TabPagerController: TabPagerController) -> [UIViewController] {
        return [self.newColoredViewController(color: .green),
                self.newColoredViewController(color: .red),
                self.newColoredViewController(color: .blue),
                self.newColoredViewController(color: .green),
                self.newColoredViewController(color: .red),
                self.newColoredViewController(color: .blue),
                self.newColoredViewController(color: .green),
                self.newColoredViewController(color: .red),
                self.newColoredViewController(color: .blue),
                self.newColoredViewController(color: .green),
                self.newColoredViewController(color: .red),
                self.newColoredViewController(color: .blue)]
    }
}

extension ViewController:TabPagerDelegate{
    
    func tabPager(_ tabPagerController: TabPagerController, currentController: UIViewController, currentIndex: Int) {
        print(currentIndex,currentController,"current")
        
    }
    
    func tabPager(_ tabPagerController: TabPagerController, previousController: UIViewController, previousIndex: Int) {
        print(previousController,previousIndex,"prev")
        
    }
    
 
    
}

