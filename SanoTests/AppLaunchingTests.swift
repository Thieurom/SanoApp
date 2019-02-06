//
//  AppLaunchingTests.swift
//  SanoTests
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Sano

class AppLaunchingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchingApp() {
        guard let appRootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            XCTFail("Failed to initialize app!")
            return
        }
        
        let initialViewController = appRootViewController.viewControllers.first!
        
        XCTAssertTrue(initialViewController is HomeViewController, "The initial view controller should be an instance of HomeViewController!")
    }
}
