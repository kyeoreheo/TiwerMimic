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
        view.backgroundColor = .systemPink
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        let feed = FeedController()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        
        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(named: "like_unselected")
        
        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(named: "mail")
        
        viewControllers = [feed, explore, notifications, conversations]
    }
}
