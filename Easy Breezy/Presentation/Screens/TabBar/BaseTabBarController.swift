//
//  BaseTabBarController.swift
//  MyApp
//
//  Created by DRC on 1/27/17.
//  Copyright © 2017 PrettyITGirl. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    let numberOfTabs: CGFloat = 4
    let tabBarHeight: CGFloat = 60

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fixBugWithWrongSizeOfTabBarItemBackground()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        fixBugWithWrongSizeOfTabBarItemBackground()
    }

    func fixBugWithWrongSizeOfTabBarItemBackground() {
        let width = tabBar.bounds.width
        var selectionImage = UIImage.imageWithColor(color: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), size: CGSize(width: width, height: tabBarHeight)).resizableImage(withCapInsets: UIEdgeInsets.zero).withRenderingMode(.alwaysOriginal)
        let tabSize = CGSize(width: width/numberOfTabs, height: tabBar.bounds.height)

        UIGraphicsBeginImageContext(tabSize)
        selectionImage.draw(in: CGRect(x: 0, y: 0, width: tabSize.width, height: tabSize.height))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        tabBar.selectionIndicatorImage = selectionImage
    }

}
