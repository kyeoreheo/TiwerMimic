//
//  CaptionTextView.swift
//  TwitterMimic
//
//  Created by Kyo on 3/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {
    // MARK:- Properties
    let placeholderLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening"
        return label
    }()
    
    // MARK:- Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        textColor = .black
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLable)
        placeholderLable.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textInput), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Selector
    @objc
    func textInput() {
        placeholderLable.isHidden = !text.isEmpty
    }
    
    
}
