//
//  GFRepoItemVC.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/27/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItemsElement()
    }
    
    private func configureItemsElement(){
        itemViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple , with: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTabGitHubProfile(for: user)
    }
    
}
