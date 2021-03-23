//
//  UserInfo.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/23/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor  = .systemBackground
        let doneBtn           = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
        print(username!)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
