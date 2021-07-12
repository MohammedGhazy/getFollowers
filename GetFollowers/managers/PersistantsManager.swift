//
//  PersistantsManager.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 4/12/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistantsManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let Favourites = "Favourites"
    }
    
    static func updateWith(favorite: Followers,  actionType: PersistenceActionType, completed: @escaping(ErrorMessage?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
   static func retrieveFavorites(completed: @escaping (Result<[Followers],ErrorMessage>) -> Void ){
    guard let favoritesData = defaults.object(forKey: Keys.Favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Followers].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableFavourites))
        }
    }
    
    
    static func save(favorites: [Followers]) -> ErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.Favourites)
            return nil
        } catch {
            return .unableFavourites
        }
    }
}
