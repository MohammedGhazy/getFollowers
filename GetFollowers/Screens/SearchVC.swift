//
//  SearchVc.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/21/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let imageLogo    = UIImageView()
    let txtField     = MyTextField()
    let btn          = GFButton(color: .systemGreen, title: "Get Followers")

    var usernameIsEmpty: Bool {!txtField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImage()
        configureTextField()
        configureBtn()
        createDismessKeyboard()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true,animated:true)
    }
    
    // ---------------------------- put app logo ------------------------//
    func configureImage(){
        view.addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogo.heightAnchor.constraint(equalToConstant: 200),
            imageLogo.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    // ---------------------------- put search text field ------------------------//
    func configureTextField(){
        view.addSubview(txtField)
        txtField.delegate = self
        NSLayoutConstraint.activate([
            txtField.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 48),
            txtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            txtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            txtField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // ---------------------------- put btn ------------------------//
    func configureBtn() {
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(pushThisToFollowersVc), for: .touchDown)
        NSLayoutConstraint.activate([
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            btn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    //------------------------ dismess keyboard --------------------------//
    func createDismessKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // --------------------- push to followers screen ----------------------//
    @objc func pushThisToFollowersVc(){
        
        guard usernameIsEmpty else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
            
        }
        
        let followersVc = FollowersListVC()
        
        followersVc.username = txtField.text
        followersVc.title = txtField.text
        
        navigationController?.pushViewController(followersVc, animated: true)
    }
}
//----------------------- textField Delegate ----------------------------//

extension SearchVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // here my logic //
       pushThisToFollowersVc()
        return true
    }
}
