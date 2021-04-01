//
//  GFUserInfoHeaderVC.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/25/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView            = GFAvatarImageView(frame: .zero)
    let usernameLabel              = GFTitleLabel(txtAlignment: .left, fontSize: 30)
    let loginNameLabel             = GFSecandryTitleLabel(fontSize: 18)
    let locationImageView          = UIImageView()
    let locationNameLabel          = GFSecandryTitleLabel(fontSize: 18)
    let bioLabel                   = GFBodyLabel(txtAlignment: .left)
    
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        layoutUI()
        configureUiElement()
    }
    
    func configureUiElement(){
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text           = user.login
        loginNameLabel.text          = user.name ?? ""
        locationNameLabel.text       = user.location ?? "No Location Avalibale"
        bioLabel.text                = user.bio ?? "No Bio Avalbale"
        bioLabel.numberOfLines       = 3
        
        locationImageView.image      = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor  = .secondaryLabel
    }
    
    func addSubViews(){
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationNameLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat      = 20
        let textPadding: CGFloat  = 16
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            loginNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            loginNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationNameLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationNameLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textPadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
}
