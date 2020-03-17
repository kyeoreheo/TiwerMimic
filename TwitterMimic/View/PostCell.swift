//
//  PostCell.swift
//  TwitterMimic
//
//  Created by Kyo on 3/17/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    // MARK:- Properties
    
    var post: Post? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48 / 2
        imageView.backgroundColor = .logoBlue
        return imageView
    }()
    
    private let contentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Some test comtent"
        label.textColor = .black
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "kyo @kyokyo"
        label.textColor = .black
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "likeUnselected"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(retweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    

    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let vStack = UIStackView(arrangedSubviews: [infoLabel, contentLabel])
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.spacing = 4
        addSubview(vStack)
        vStack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        let hStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        hStack.axis = .horizontal
        hStack.spacing = 72
        
        addSubview(hStack)
        hStack.centerX(inView: self)
        hStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Selectors
    
    @objc
    func commentTapped() {
        
    }
    
    @objc
    func retweetTapped() {
        
    }
    
    @objc
    func likeTapped() {
        
    }
    
    @objc
    func shareTapped() {
        
    }
    // MARK:- Helpers
    
    func configure() {
        guard let post = post else { return }
        profileImageView.sd_setImage(with: post.user.profileImageUrl)
        infoLabel.text = post.user.username
        
        
    }
}
