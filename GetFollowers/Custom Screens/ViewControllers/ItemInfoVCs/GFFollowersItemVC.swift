//
//  GFFollowersItemVC.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/27/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class GFFollowersItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItemsElement()
    }
    
    private func configureItemsElement(){
        itemViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemViewTwo.set(itemInfoType: .following, withCount: user.following)

        actionButton.set(backgroundColor: .systemGreen , with: "Git Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTabGitHubFollowers(for: user)
    }
}
