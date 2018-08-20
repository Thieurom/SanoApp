//
//  AppDelegate.swift
//  Three
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = window ?? UIWindow()
        window!.backgroundColor = .white
        
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // customize navigation controller's bar
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
}
