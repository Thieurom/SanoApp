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
        XCTAssertTrue(button.isDescendant(of: sut.view), "a")
    }
}
