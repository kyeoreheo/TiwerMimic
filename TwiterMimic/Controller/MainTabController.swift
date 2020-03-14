//
//  MainTabController.swift
//  TwiterMimic
//
//  Created by Kyo on 3/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - properties
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        //view.backgroundColor = .systemPink
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        //let feed = FeedController()
        let feed = templateNavigationController(image: UIImage(named: "homeUnselected"),
                                                rootViewController: FeedController())
        
        let explore = templateNavigationController(image: UIImage(named: "searchUnselected"),
                                                   rootViewController: ExploreController())
        
        let notifications = templateNavigationController(image: UIImage(named: "likeUnselected"),
                                                         rootViewController: NotificationsController())
        
        let conversations = templateNavigationController(image: UIImage(named: "mail"),
                                                         rootViewController: ConversationsController())
        
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)
        -> UINavigationController {
        let myNavigation =  UINavigationController(rootViewController: rootViewController)
            myNavigation.tabBarItem.image = image
            myNavigation.navigationBar.barTintColor = .white
        return myNavigation
    }
}
