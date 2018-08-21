//
//  HomeViewControllerTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = HomeViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testHasPlayWithFriendButton() {
        let button = sut.playWithFriendButton
        XCTAssertTrue(button.isDescendant(of: sut.view), "The playWithFriendButton is not in view hierarchy!")
    }
    
    func testPlayWithFriendAction() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        let button = sut.playWithFriendButton
        button.sendActions(for: .touchUpInside)
        
        let nextViewController = mockNavigationController.lastPushedViewController
        
        XCTAssertTrue(nextViewController is SettingViewController, "An instance of SettingViewController was not displayed when pressing playWithFriendButton!")
    }
}

// MARK: - HomeViewControllerTests Extensions

extension HomeViewControllerTests {
    
    // MockNavigationController
    class MockNavigationController: UINavigationController {
        
        var lastPushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            lastPushedViewController =  viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
