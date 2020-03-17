//
//  PostController.swift
//  TwitterMimic
//
//  Created by Kyo on 3/15/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class PostController: UIViewController {
    // MARK:- Properties
    private let user: User
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .logoBlue
        button.setTitle("Post", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x:0, y:0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(post), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48 / 2
        imageView.backgroundColor = .logoBlue
        return imageView
    }()
    
    private let captionTextView = CaptionTextView()
    
    // MARK:- Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK:- Selectors
    
    @objc
    func cancelPost() {
        dismiss(animated: true)
    }
    
    @objc
    func post() {
        guard let content = captionTextView.text else { return }
        PostService.shared.post(contentt: content) { (error, ref) in
            if let error = error {
                print("DEBUG:- filaed to upload with \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true)
        }
    }
    // MARK:- API
    
    // MARK:- Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let HStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        HStack.axis = .horizontal
        HStack.spacing = 12
        
        view.addSubview(HStack)
        HStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageUrl)
        //once it fetch, it loads from caches. so no extra fetch
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPost))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}

