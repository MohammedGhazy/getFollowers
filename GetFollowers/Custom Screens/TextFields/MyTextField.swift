//
//  MyTextField.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMyTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureMyTextField(){
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.systemGray4.cgColor
        
        textColor                                   = .label
        tintColor                                   = .label
        
        backgroundColor                             = .tertiarySystemBackground
        
        textAlignment                               = .center
        returnKeyType                               = .go
        
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12
        autocorrectionType                          = .no
        
        placeholder                                 = "Enter a username"
        
        font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
}
