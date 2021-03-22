//
//  GFButton.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor , title: String) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        configureBtn()
    }
    
    private func configureBtn(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
