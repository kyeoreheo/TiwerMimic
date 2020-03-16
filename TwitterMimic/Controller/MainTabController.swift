//
//  MainTabController.swift
//  TwitterMimic
//
//  Created by Kyo on 3/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - properties
    
    var user: User? {
        didSet {
            guard let navigation = viewControllers?[0] as? UINavigationController,
                  let feed = navigation.viewControllers.first as? FeedController
            else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.tintColor = .white
        myButton.backgroundColor = .logoBlue
        myButton.setImage(UIImage(named: "newTweet"), for: .normal)
        myButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return myButton
    }()
    
    // MARK: - API
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logUserOut()
        view.backgroundColor = .logoBlue
        autenticateUserAndConfigureUI()
    }
    
    // MARK: - Selectors
    
    @objc
    func actionButtonTapped() {
        guard let user = user else { return }
        let navigation = UINavigationController(rootViewController: PostController(user: user))
        present(navigation, animated: true, completion: nil)
    }
    
    // MARK: - configures
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("------failed to sing out \(error.localizedDescription)")
        }
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
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)
        -> UINavigationController {
        let myNavigation = UINavigationController(rootViewController: rootViewController)
            myNavigation.tabBarItem.image = image
            //myNavigation.navigationBar.barTintColor = .white
        return myNavigation
    }
    
    func autenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: LoginController())
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
            }
        } else {
            configureUI()
            configureViewControllers()
            fetchUser()
        }
    }
}
