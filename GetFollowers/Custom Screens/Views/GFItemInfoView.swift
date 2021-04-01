//
//  GFItemInfoView.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/25/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

enum itemInfoType {
    case repos , gists , followers , following
}

class GFItemInfoView: UIView {

    let sympolImageView    = UIImageView()
    let titleLabel         = GFTitleLabel(txtAlignment: .left, fontSize: 14)
    let countLabel         = GFTitleLabel(txtAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(sympolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        sympolImageView.translatesAutoresizingMaskIntoConstraints  = false
        sympolImageView.contentMode   = .scaleAspectFit
        sympolImageView.tintColor     = .label
        
        
        NSLayoutConstraint.activate([
           
            sympolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            sympolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sympolImageView.heightAnchor.constraint(equalToConstant: 20),
            sympolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: sympolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: sympolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: sympolImageView.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func set(itemInfoType: itemInfoType , withCount count: Int){
        switch itemInfoType {
        case .repos:
            sympolImageView.image  = UIImage(systemName: SFSymbols.repos)
            titleLabel.text        = "Public Repos"
        case .gists:
            sympolImageView.image  = UIImage(systemName: SFSymbols.gists)
            titleLabel.text        = "Public Gists"
        case .followers:
            sympolImageView.image  = UIImage(systemName: SFSymbols.followers)
            titleLabel.text        = "Followers"
        case .following:
            sympolImageView.image  = UIImage(systemName: SFSymbols.following)
            titleLabel.text        = "Following"
        }
        countLabel.text            = String(count)
    }
    
}
