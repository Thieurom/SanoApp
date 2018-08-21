//
//  SettingViewControllerTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class SettingViewControllerTests: XCTestCase {
    
    var sut: SettingViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = SettingViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testHasSelectionView() {
        let view = sut.selectionView
        
        XCTAssertTrue(view.isDescendant(of: sut.view), "The selectionView is not in view hierarchy!")
    }
    
    func testHasStartButton() {
        let button = sut.startButton
        
        XCTAssertTrue(button.isDescendant(of: sut.view), "The startButton is not in the view hierarchy!")
    }
}
