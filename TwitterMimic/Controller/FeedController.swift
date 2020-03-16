//
//  FeedController.swift
//  TwitterMimic
//
//  Created by Kyo on 3/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - properties
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "logoBlue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .logoBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
