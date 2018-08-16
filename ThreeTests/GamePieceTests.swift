//
//  GamePieceTests.swift
//  ThreeTests
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import Three

class GamePieceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGamePieceOpposite() {
        var piece: GamePiece = .solid
        XCTAssertEqual(piece.opposite, .donut)
        
        piece = .donut
        XCTAssertEqual(piece.opposite, .solid)
    }
    
    func testGamePieceDescription() {
        var piece: GamePiece = .solid
        XCTAssertEqual(piece.description, "●")
        
        piece = .donut
        XCTAssertEqual(piece.description, "○")
    }
}
