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
    
    let actionButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.tintColor = .white
        myButton.backgroundColor = .blue
        myButton.setImage(UIImage(named: "newTweet"), for: .normal)
        return myButton
    }()
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
        //view.backgroundColor = .systemPink
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        let feed = templateNavigationController(image: UIImage(named: "homeUnselected"),
                                                rootViewController: FeedController())
        
        let explore = templateNavigationController(image: UIImage(named: "searchUnselected"),
                                                   rootViewController: ExploreController())
        
        let notifications = templateNavigationController(image: UIImage(named: "likeUnselected"),
                                                         rootViewController: NotificationsController())
        
        let conversations = templateNavigationController(image: UIImage(named: "mail"),
                                                         rootViewController: ConversationsController())
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black]
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)
        -> UINavigationController {
        let myNavigation = UINavigationController(rootViewController: rootViewController)
            myNavigation.tabBarItem.image = image
            //myNavigation.navigationBar.barTintColor = .white
        return myNavigation
    }
}
