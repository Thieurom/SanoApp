//
//  GameManagerTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class GameManagerTests: XCTestCase {
    
    var gameManager: GameManager!
    var gameBoard: GameBoard!
    
    override func setUp() {
        super.setUp()
        
        gameManager = GameManager(boardSize: 3, firstPlayingPiece: .solid)
        gameBoard = gameManager.newBoard()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstPlayingPieceOfNewGame() {
        XCTAssertEqual(gameManager.boardSize, 3)
        XCTAssertEqual(gameManager.firstPlayingPiece, .solid)
    }
    
    func testCreateNewGameBoard() {
        XCTAssertEqual(gameBoard.firstPiece, .solid)
        XCTAssertNil(gameBoard.lastPlacedPiece, "The newly-created board should be all empty !")
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 0)
    }
    
    func testAddWinningGameBoard() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 0, column: 2)
        
        XCTAssertTrue(gameBoard.hasWinningPiece(), "The board should has the winning piece!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            XCTFail("The board that has winning piece should be able to be added!")
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
    }
    
    func testAddDrawEndingGameBoard() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 2, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 2)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 2, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 2)
        try! gameBoard.placeNextPiece(toRow: 2, column: 2)

        XCTAssertTrue(gameBoard.isDrawEnding(), "The board should end with a draw!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            XCTFail("The board that ends with a draw should be able to be added!")
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
    }
    
    func testAddWinningGameBoardWithInvalidFirstPiece() {
        var otherBoard = GameBoard(size: 3, firstPiece: .donut)
        
        // swiftlint:disable force_try
        try! otherBoard.placeNextPiece(toRow: 0, column: 0)
        try! otherBoard.placeNextPiece(toRow: 1, column: 0)
        try! otherBoard.placeNextPiece(toRow: 0, column: 1)
        try! otherBoard.placeNextPiece(toRow: 1, column: 1)
        try! otherBoard.placeNextPiece(toRow: 0, column: 2)
        
        XCTAssertTrue(otherBoard.hasWinningPiece(), "The board should has the winning piece!")
        
        do {
            try gameManager.addCompletedBoard(otherBoard)
            XCTFail("The board that has invalid first piece should not be able to be added!")
        } catch GameManagerError.invalidFirsPlayingPiece {
            XCTAssertEqual(gameManager.numberOfPlayedBoards, 0)
        } catch {
            XCTFail("Incorrect thrown error when adding the board!")
        }
    }
    
    func testAddDrawEndingGameBoardWithInvalidFirstPiece() {
        var otherBoard = GameBoard(size: 3, firstPiece: .donut)
        
        // swiftlint:disable force_try
        try! otherBoard.placeNextPiece(toRow: 0, column: 0)
        try! otherBoard.placeNextPiece(toRow: 0, column: 1)
        try! otherBoard.placeNextPiece(toRow: 1, column: 0)
        try! otherBoard.placeNextPiece(toRow: 2, column: 0)
        try! otherBoard.placeNextPiece(toRow: 0, column: 2)
        try! otherBoard.placeNextPiece(toRow: 1, column: 1)
        try! otherBoard.placeNextPiece(toRow: 2, column: 1)
        try! otherBoard.placeNextPiece(toRow: 1, column: 2)
        try! otherBoard.placeNextPiece(toRow: 2, column: 2)
        
        XCTAssertTrue(otherBoard.isDrawEnding(), "The board should end with a draw!")

        do {
            try gameManager.addCompletedBoard(otherBoard)
            XCTFail("The board that has invalid first piece should not be able to be added!")
        } catch GameManagerError.invalidFirsPlayingPiece {
            XCTAssertEqual(gameManager.numberOfPlayedBoards, 0)
        } catch {
            XCTFail("Incorrect thrown error when adding the board!")
        }
    }
    
    func testAddIncompleteGameBoard() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        
        XCTAssertFalse(gameBoard.hasWinningPiece(), "The board should not have winning piece yet!")
        XCTAssertFalse(gameBoard.isDrawEnding(), "The board should not end with a draw yet!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
            XCTFail("The incompleted board should not be able to be added!")
        } catch GameManagerError.incompleteBoard {
            XCTAssertEqual(gameManager.numberOfPlayedBoards, 0)
        } catch {
            XCTFail("Incorrect thrown error when adding the board!")
        }
    }
    
    func testCreateSecondGameBoardAfterAWinByFirstPlayingPiece() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 0, column: 2)
        
        XCTAssertTrue(gameBoard.hasWinningPiece(), "The board should has the winning piece!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            fatalError()
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
        
        let secondBoard = gameManager.newBoard()
        XCTAssertEqual(secondBoard.firstPiece, .solid)
    }
    
    func testCreateSecondGameBoardAfterALostByFirstPlayingPiece() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 2, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 2)
        
        XCTAssertTrue(gameBoard.hasWinningPiece(), "The board should has the winning piece by donut!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            fatalError()
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
        
        let secondBoard = gameManager.newBoard()
        XCTAssertEqual(secondBoard.firstPiece, .donut)
    }
    
    func testCreateSecondGameBoardAfterADraw() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 2, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 2)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 2, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 2)
        try! gameBoard.placeNextPiece(toRow: 2, column: 2)
        
        XCTAssertTrue(gameBoard.isDrawEnding(), "The board should end with a draw!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            fatalError()
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
        
        let secondBoard = gameManager.newBoard()
        XCTAssertEqual(secondBoard.firstPiece, .donut)
    }
    
    func testNumberOfWinnings() {
        // swiftlint:disable force_try
        try! gameBoard.placeNextPiece(toRow: 0, column: 0)
        try! gameBoard.placeNextPiece(toRow: 1, column: 0)
        try! gameBoard.placeNextPiece(toRow: 0, column: 1)
        try! gameBoard.placeNextPiece(toRow: 1, column: 1)
        try! gameBoard.placeNextPiece(toRow: 0, column: 2)
        
        XCTAssertTrue(gameBoard.hasWinningPiece(), "The board should has the winning piece!")
        
        do {
            try gameManager.addCompletedBoard(gameBoard)
        } catch {
            XCTFail("The board that has winning piece should be able to be added!")
        }
        
        XCTAssertEqual(gameManager.numberOfPlayedBoards, 1)
        XCTAssertEqual(gameManager.winningCount(by: .solid), 1)
        XCTAssertEqual(gameManager.winningCount(by: .donut), 0)
    }
}
