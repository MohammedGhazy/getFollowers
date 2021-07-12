//
//  FavoritesCell.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 4/13/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let reuseId = "FollowerCell"
    
    let avatarImage = GFAvatarImageView(frame: .zero)
    let titleLabel  = GFTitleLabel(txtAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorites: Followers){
        titleLabel.text   = favorites.login
        avatarImage.downloadImage(from: favorites.avatarUrl)
    }
    
    private func configure(){
        addSubview(avatarImage)
        addSubview(titleLabel)
        
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
        
        ])
    }
}
