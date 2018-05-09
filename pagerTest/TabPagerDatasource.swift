//
//  TabPagerDatasource.swift
//  TabPager
//
//  Created by Albin CR on 5/2/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

//MARK:- Datasource for TabPager - Contract
protocol TabPagerDataSource:class{
    
//    //MARK:- Should return total no of controller to display in TabPager
//    func numberOfViewController(in TabPagerController:TabPagerController)->Int
//
//    //MARK:- Returns viewConteoller to display for current index
//    func tabPagerAtIndex(for TabPagerController:TabPagerController,at index: controllerIndex) -> UIViewController?
//
//    //MARK:- Returns default viewController
//    func tabPagerDefaultController(for TabPagerController:TabPagerController) -> Page?
 
    func initialPagerIndex(for TabPagerController:TabPagerController) -> Int
    
    func setPagerControllers(for TabPagerController:TabPagerController) -> [UIViewController]
    
}


