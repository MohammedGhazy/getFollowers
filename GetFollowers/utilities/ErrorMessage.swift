//
//  ErrorMessage.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/22/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import Foundation

enum ErrorMessage: String , Error {
    case invalidUserName        = "username invalid please try to enter valid user"
    case internetError          = "you request incomplete please check internet connection"
    case serverError            = "Error from server..."
    case invalidData            = "the data was recieved invalid..."
    case unableFavourites       = "Unable to Load Favourites please try again..."
    case alreadyInFavorites     = "Already in favourites..."
}
