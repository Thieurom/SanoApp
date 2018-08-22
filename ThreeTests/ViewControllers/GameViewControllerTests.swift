//
//  GameViewControllerTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/22/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class GameViewControllerTests: XCTestCase {
    
    var sut: GameViewController!
    var gameManager: GameManager!
    
    override func setUp() {
        super.setUp()
        
        gameManager = GameManager(boardSize: 3, firstPlayingPiece: .solid)
        sut = GameViewController(gameManager: gameManager)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testHasGameManager() {
        XCTAssertNotNil(sut.gameManager, "The gameViewController should have property gameManager set after being initialized!")
    }
}
