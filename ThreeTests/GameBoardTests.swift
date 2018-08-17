//
//  GameBoardTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class GameBoardTests: XCTestCase {
    
    var board: GameBoard!
    
    override func setUp() {
        super.setUp()
        
        let piece: GamePiece = .solid
        board = GameBoard(size: 3, firstPiece: piece)
    }
    
    override func tearDown() {
        board = nil
        super.tearDown()
    }
    
    func testNewGameBoard() {
        XCTAssertEqual(board.size, 3)
        XCTAssertEqual(board.firstPiece, .solid)
    }
    
    func testPlaceValidPieceOnTheBoard() {
        XCTAssertNil(board.lastPlacedPiece)
        XCTAssertEqual(board.nextPlacingPiece, .solid)
        
        // place next piece to the top-left of the board (0,0)
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
        
        XCTAssertEqual(board.nextPlacingPiece, .donut)
        
        // place next piece to the center of the board (1,1)
        do {
            try board.placeNextPiece(toRow: 1, column: 1)
            XCTAssertEqual(board.lastPlacedPiece, .donut)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
    }
    
    func testPlacePieceOutsideTheBoard() {
        do {
            try board.placeNextPiece(toRow: 3, column: 3)
            XCTFail("The game board should not be mutated succefully when placing piece outside the board!")
        } catch GameBoardError.outOfBoard {
            XCTAssertNil(board.lastPlacedPiece)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
    
    func testPlacePieceOnThePlacedLocation() {
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("The game board should be mutated without error!")
        }
        
        do {
            try board.placeNextPiece(toRow: 0, column: 0)
            XCTFail("The game board should not be mutated succefully when placing piece on the already-placed location!")
        } catch GameBoardError.notEmptyLocation {
            XCTAssertEqual(board.lastPlacedPiece, .solid)
        } catch {
            XCTFail("Incorrect thrown error when mutating the board!")
        }
    }
}
