//
//  AppDelegate.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = window ?? UIWindow()
        
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
}
