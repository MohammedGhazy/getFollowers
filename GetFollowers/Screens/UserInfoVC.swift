//
//  UserInfo.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/23/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTabGitHubProfile(for user: User)
    func didTabGitHubFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView           = UIView()
    let itemViewOne          = UIView()
    let itemViewTwo          = UIView()
    let dateLabel            = GFBodyLabel(txtAlignment: .center)
    
    var itemViews: [UIView]  = []
    
    var username: String!
    weak var delegate: FollowersListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInfoView()
        getUserInfo()
        layoutUI()
    }
    
    
    func configureUserInfoView(){
        view.backgroundColor              = .systemBackground
        let doneBtn                       = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    func getUserInfo(){
        NetWorkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElement(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "sorry! something wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    func configureUIElement(with user: User){
        let repoItemVC           = GFRepoItemVC(user: user)
        repoItemVC.delegate      = self
        
        let followerItemVC       = GFFollowersItemVC(user: user)
        followerItemVC.delegate  = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text  = "GitHub Scince \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI()  {
        
        let padding:    CGFloat      = 20
        let itemHeight: CGFloat      = 140
        
        itemViews = [headerView , itemViewOne , itemViewTwo,dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
            itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
    
            ])
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController , to containerVieww: UIView){
        addChild(childVC)
        containerVieww.addSubview(childVC.view)
        childVC.view.frame = containerVieww.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate{
    func didTabGitHubProfile(for user: User) {
        guard let url   = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "invalid username", message: "the url attached is invalid", buttonTitle: "Ok")
            return
        }
        makeSafariVC(with: url)
    }
    
    func didTabGitHubFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
