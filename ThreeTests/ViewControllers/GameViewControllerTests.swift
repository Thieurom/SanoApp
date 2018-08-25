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
    
    func testHasGameBoard() {
        let gameBoard = sut.currentGameBoard
        
        XCTAssertNotNil(gameBoard, "The gameViewController should have property currentGameBoard set after its view being loaded")
        
        XCTAssertEqual(gameBoard?.firstPiece, .solid, "The first piece of the first game board should be solid by default!")
    }
    
    func testHasGameBoardView() {
        XCTAssertTrue(sut.gameBoardView.isDescendant(of: sut.view), "The gameBoardView should be in view hierarchy!")
    }
    
    func testGameBoardViewSetDelegate() {
        XCTAssertTrue(sut.gameBoardView.delegate is GameViewController, "The gameBoardView's delegte should be set to an intance of GameViewController!")
    }
    
    func testHasGameScoringView() {
        XCTAssertTrue(sut.gameScoringView.isDescendant(of: sut.view), "The gameScoringView should be in view hierarchy!")
    }
    
    func testHasGameCommentaryView() {
        XCTAssertTrue(sut.gameCommentaryView.isDescendant(of: sut.view), "The gameCommentaryView should be in view hierarchy!")
    }
    
    func testHasPlayNewGameBoardButton() {
        XCTAssertTrue(sut.gameScoringView.isDescendant(of: sut.view), "The playNewGameBoardButton should be in view hierarchy!")
    }
}
