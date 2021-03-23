//
//  User.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
    
}
