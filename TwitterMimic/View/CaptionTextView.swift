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
        return label
    }()
    
    // MARK:- Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLable)
        placeholderLable.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 8, paddingLeft: 8)
    }
    
}
