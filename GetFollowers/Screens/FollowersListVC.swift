//
//  FollowersListVc.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum  Section {
        case main
    }
    
    var username: String!
    var followers: [Followers] = []
    var filterArray: [Followers] = []
    var page: Int = 1
    var hasMoreFollowers = true
    var searching        = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section , Followers>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchController()
        configureViewController()
        getFollower(username: username, page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false,animated:true)
    }
    
    func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate  = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func configureSearchController(){
        let searchController                     = UISearchController()
        searchController.searchResultsUpdater    = self
        searchController.searchBar.delegate                = self
        searchController.searchBar.placeholder   = "Search For A Username."
        navigationItem.searchController          = searchController
    }
    
    func getFollower(username: String , page: Int){
       showProgressIndicator()
       NetWorkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
        guard let self = self else{return}
        self.dismissIndicator()
            switch result {
            case .success(let followers) :
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty{
                    let message = "this user has no follwers. please try to search another user"
                    DispatchQueue.main.async {
                        self.showEmptyState(with: message, in: self.view)
                        return
                    }
                    
                }
                self.updateData(on: self.followers)
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Oooops", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section , Followers>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section , Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offesetY       = scrollView.contentOffset.y
        let contentSize    = scrollView.contentSize.height
        let height         = scrollView.frame.size.height
        
        
        if offesetY > contentSize - height{
            guard hasMoreFollowers else { return }
            page += 1
            getFollower(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray      = searching ? filterArray : followers
        let followers        = activeArray[indexPath.item]
        let destination      = UserInfoVC()
        destination.username = followers.login
        let navController    = UINavigationController(rootViewController: destination)
        
        present(navController, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else{ return }
        searching        = true
        filterArray      = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filterArray)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching  = false
        updateData(on: followers)
    }
    
    
}
