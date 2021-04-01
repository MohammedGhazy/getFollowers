//
//  NetworkManager.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class NetWorkManager {
    
    let baseUrl = "https://api.github.com"
    let cache   = NSCache<NSString , UIImage>()
    
    static let shared = NetWorkManager()
    
    private init(){}
    
    func getFollowers(for username: String , page: Int, complete: @escaping (Result<[Followers] , ErrorMessage>) -> Void) {
        let endPoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            complete(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                complete(.failure(.internetError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
                complete(.failure(.serverError))
                return
            }
            
            guard let data = data else{
                complete(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                complete(.success(followers))
            }catch{
                complete(.failure(.invalidData))
            }
        }
        task.resume()
            
        }
    
    
    
    func getUserInfo(for username: String , complete: @escaping (Result< User , ErrorMessage>) -> Void)
    {
          
        let endPoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endPoint) else {
            complete(.failure(.invalidUserName))
            return
        }
        
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                complete(.failure(.internetError))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                complete(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                complete(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode(User.self, from: data)
                complete(.success(users))
            }catch{
                complete(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    
     }
