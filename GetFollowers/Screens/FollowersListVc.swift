//
//  FollowersListVc.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class FollowersListVc: UIViewController {
    
    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
    }


}
