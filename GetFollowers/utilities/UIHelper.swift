//
//  UIHelper.swift
//  GetFollowers
//
//  Created by Mohamed Ghazy on 3/22/21.
//  Copyright © 2021 Mohamed Ghazy. All rights reserved.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                     = view.bounds.width
        let padding: CGFloat          = 8
        let minItemSpacing: CGFloat   = 10
        let avalibaleWidth            = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth                 = avalibaleWidth / 3
        
        let flowLayout                = UICollectionViewFlowLayout()
        flowLayout.sectionInset       = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize           = CGSize(width: itemWidth , height: itemWidth + 40)
        
        return flowLayout
    }
}
