//
//  MenuViewControllerTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/28/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class MenuViewControllerTests: XCTestCase {
    
    var sut: MenuViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = MenuViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
