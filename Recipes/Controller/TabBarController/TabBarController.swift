//
//  TabBarController.swift
//  Recipes
//
//  Created by Mohammad Olwan on 15/03/2022.
//

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    

    @IBOutlet weak var mainTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tabBarItemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        tabBarItemAppearance.normal.titleTextAttributes  = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20) as Any]
        
        tabBarAppearance.backgroundColor = UIColor.black
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBarAppearance.stackedItemSpacing = CGFloat(9.0)
        
        
        mainTabBar.standardAppearance = tabBarAppearance
        mainTabBar.scrollEdgeAppearance = tabBarAppearance
        mainTabBar.layer.borderWidth = 0.1
        mainTabBar.layer.borderColor = UIColor.clear.cgColor
        mainTabBar.clipsToBounds = true
        let bgView = UIImageView(image: UIImage(named: "tabBarBG"))
        bgView.frame = self.tabBar.bounds
        self.mainTabBar.addSubview(bgView)
        self.mainTabBar.sendSubviewToBack(bgView)
        navigationController?.navigationBar.barTintColor = UIColor.green
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        
        
        mainTabBar.barStyle = UIBarStyle.black
        mainTabBar.layer.borderColor = UIColor.white.cgColor
        
        
    }
}
