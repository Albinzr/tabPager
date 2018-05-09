//
//  TabPagerController.swift
//  TabPager
//
//  Created by Albin CR on 5/2/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

open class TabPagerController: UIView {
    
    
    lazy var tabView:Tabar = {
        
        let view = Tabar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.tabPager = self
        return view
        
    }()
    
    weak var dataSource: TabPagerDataSource?{
        didSet{
            self.orderedViewControllers = (dataSource?.setPagerControllers(for: self))!
            self.initialControllerIndex = dataSource?.initialPagerIndex(for: self)
            self.tabView.tabCount = orderedViewControllers.count
        }
    }
    
    weak var delegate: TabPagerDelegate?{
        didSet{
            if let controllerIndex = initialControllerIndex{
                if orderedViewControllers.count>0{
                    delegate?.tabPager(self, currentController: orderedViewControllers[controllerIndex], currentIndex:controllerIndex)
                }
            }
        }
    }
    
    
    private(set) var initialControllerIndex:Int?{
        didSet{
            
            pageController.setViewControllers([orderedViewControllers[initialControllerIndex!]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
            if let tabPagerDelegate = delegate{
                if let controllerIndex = initialControllerIndex{
                    if orderedViewControllers.count>0{
                        tabPagerDelegate.tabPager(self, currentController: orderedViewControllers[controllerIndex], currentIndex:controllerIndex)
                    }
                }
            }
        }
    }
    private(set) lazy var orderedViewControllers: [UIViewController] = []
    
    var pageController: UIPageViewController = {
        let pager = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pager.view.translatesAutoresizingMaskIntoConstraints = false
        return pager
        
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        if let pageController = self.pageController.view{
            
            self.addSubview(pageController)
            self.addSubview(tabView)
            NSLayoutConstraint.activate([
                tabView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                tabView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
                tabView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
                tabView.heightAnchor.constraint(equalToConstant: 64),
                
                pageController.topAnchor.constraint(equalTo: self.tabView.bottomAnchor),
                pageController.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
                pageController.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
                pageController.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
                
                ])
        }
        pageController.delegate = self
        pageController.dataSource = self
    }
    
}

extension TabPagerController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if let tabPagerDelegate = delegate{
            if let controller = pendingViewControllers.first{
                if let controllerIndex = orderedViewControllers.index(of: controller){
                    tabPagerDelegate.tabPager(self, currentController: controller, currentIndex:controllerIndex)
                    let indexPath = IndexPath(row: controllerIndex, section: 0)
                    tabView.tabarCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                    tabView.tabarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
                    
                    if let currentCell = tabView.tabarCollectionView.cellForItem(at: indexPath){

                        self.tabView.horizontalBarLeftAnchorConstraint?.constant = (currentCell.frame.origin.x)
                        print(currentCell.frame.minX)
                        self.tabView.horizontalBarWidthAnchorConstraint?.constant = (currentCell.frame.width)
                        
                        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            UIView.animate(withDuration: 5) {
                                self.layoutIfNeeded()
                            }
                            
                        }, completion: nil)
                    }
                }
            }
        }
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let tabPagerDelegate = delegate{
            if let controller = previousViewControllers.first{
                if let controllerIndex = orderedViewControllers.index(of: controller){
                    tabPagerDelegate.tabPager(self, previousController: controller, previousIndex: controllerIndex)
                }
            }
        }
    }
    
    
    
}
