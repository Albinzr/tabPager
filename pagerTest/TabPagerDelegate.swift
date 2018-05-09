//
//  TabPagerDelegate.swift
//  PageTab
//
//  Created by Albin CR on 5/2/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

public protocol TabPagerDelegate:class{
    
    
    
    //MARK:- didScroll
    
    
    //MARK:- currentScroll position
    func tabPager(_ tabPagerController:TabPagerController,currentController:UIViewController,currentIndex:Int)
    func tabPager(_ tabPagerController:TabPagerController,previousController:UIViewController,previousIndex:Int)
    
    //MARK:- currentViewController
    //    func tabPager(_ tabPagerController:TabPagerController, didReload controller:UIViewController, currentIndex:controllerIndex)
    
}

//MARK:- making all the above delegate method optional using extension

extension TabPagerDelegate{
    func tabPager(_ tabPagerController:TabPagerController,currentController:UIViewController,currentIndex:Int){}
    func tabPager(_ tabPagerController:TabPagerController,previousController:UIViewController,previousIndex:Int){}
    //    func tabPager(_ tabPagerController:TabPagerController, didReload controller:UIViewController, currentIndex:controllerIndex){}
}
