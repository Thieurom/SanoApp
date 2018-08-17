//
//  GameBoard.swift
//  Three
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/// Represent a square board
/// A board has a fixed, same number of rows and columns
/// A board also has the first piece, which is allowed to place on the empty board
/// When one wants to place a piece on the board
struct GameBoard {
    
    /// The size of the board
    let size: Int
    
    /// The (initial) piece that is allowed to place on the empty board
    let firstPiece: GamePiece
    // This is for easy managing of correct consequence piece will be placed on
    // the board
    
    // This is a 2-dimension array of optional GamePiece
    // Each location on the board is internally determined by board[row][column]
    // The `nil` value indicates the location is empty
    private var board: [[GamePiece?]]
    
    private var numberOfPlacedPiece = 0
    
    /// Create new game board
    ///
    /// - Parameters:
    ///     - size: The size (rows and columns) of the board
    ///     - firstPiece: The first piece of the board
    init(size: Int, firstPiece: GamePiece) {
        self.size = size
        self.firstPiece = firstPiece
        
        let row: [GamePiece?] = Array(repeating: nil, count: size)
        self.board = Array(repeating: row, count: size)
    }
}

extension GameBoard {
    
    /// Return the last placed piece on the board
    var lastPlacedPiece: GamePiece? {
        guard numberOfPlacedPiece > 0 else {
            return nil
        }
        
        return (numberOfPlacedPiece % 2 != 0) ? firstPiece : firstPiece.opposite
    }
    
    /// Return the piece that should be placed on the board for the next placement
    var nextPlacingPiece: GamePiece {
        return (numberOfPlacedPiece % 2 == 0) ? firstPiece : firstPiece.opposite
    }
}

extension GameBoard {
    
    /// Place the next playing piece on the board to given row and column
    ///
    /// - Parameters:
    ///     - row: The row or horizontal location of the piece
    ///     - column: The column or vertical location of the piece
    /// - Throws:
    ///     - `GameBoardError.outOfBoard` if the `row` and/or `column` is out of bound of the board
    ///     - `GameBoardError.placedLocation` if the location determined by `row` and `column` is already placed
    mutating func placeNextPiece(toRow row: Int, column: Int) throws {
        guard isRowInBound(row) && isColumnInBound(column) else {
            throw GameBoardError.outOfBoard
        }
        
        guard board[row][column] == nil else {
            throw GameBoardError.notEmptyLocation
        }
        
        board[row][column] = nextPlacingPiece
        numberOfPlacedPiece += 1
    }
}

extension GameBoard {
    
    // Check whether a given number is invalid row
    // This check together with isColumnInBound(:) to make sure a location
    // specified with a row and column is inside the board
    private func isRowInBound(_ row: Int) -> Bool {
        return row >= 0 && row < size
    }
    
    // Check whether a given number is invalid column
    // This check together with isRowInBound(:) to make sure a location
    // specified with a row and column is inside the board
    private func isColumnInBound(_ column: Int) -> Bool {
        return column >= 0 && column < size
    }
}
