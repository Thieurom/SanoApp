//
//  GameViewControllerTests.swift
//  SanoTests
//
//  Created by Doan Le Thieu on 8/22/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Sano

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
      
    func testGameBoardViewSetDelegate() {
        XCTAssertTrue(sut.gameView.gameBoardView.delegate is GameViewController, "The gameBoardView's delegte should be set to an intance of GameViewController!")
    }
    
    func testHasGameScoringView() {
        XCTAssertTrue(sut.gameScoringView.isDescendant(of: sut.view), "The gameScoringView should be in view hierarchy!")
    }
    
    func testMenuButton() {
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.loadViewIfNeeded()
        
        let button = sut.navigationItem.leftBarButtonItem
        
        XCTAssertNotNil(button, "There should be a leftBarButtonItem!")
    }
    
    func testMenuButtonAction() {
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.loadViewIfNeeded()
        
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        guard let button = sut.navigationItem.leftBarButtonItem else {
            XCTFail("There should be a leftBarButtonItem!")
            return
        }
        
        sut.perform(button.action, with: nil)
        
        guard let nextViewController = sut.presentedViewController as? MenuViewController else {
            XCTFail("The modally-presented view controller should be an instance of MenuViewController!")
            return
        }
        
        XCTAssertEqual(nextViewController.numberOfMenuActions, 2, "The MenuViewController is displayed with 2 action (quit and restart)!")
    }
}
