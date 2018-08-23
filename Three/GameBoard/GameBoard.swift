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

extension GameBoard: CustomStringConvertible {
    
    var description: String {
        var output = ""
        
        for row in 0..<size {
            if row == 0 {
                output += String(repeating: ".___", count: size)
            } else {
                output += String(repeating: "|---", count: size)
            }
            
            output += "|\n"
            
            for column in 0..<size {
                let piece = board[row][column]
                let pieceText = piece?.description ?? " "
                output += "| \(pieceText) "
            }
            
            output += "|\n"
        }
        
        output += String(repeating: "'---", count: size)
        output += "'"
        
        return output
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
        
        guard !hasWinningPiece() && !isDrawEnding() else {
            throw GameBoardError.completed
        }
        
        guard board[row][column] == nil else {
            throw GameBoardError.notEmptyLocation
        }
        
        board[row][column] = nextPlacingPiece
        numberOfPlacedPiece += 1
    }
}

extension GameBoard {
    
    /// Query the game piece at given location specified by `row` and `column`
    ///
    /// - Returns: `nil` if the `row` and/or `column` is out of bound,
    /// or the location is valid but is empty,
    /// otherwise return the game piece
    func piece(atRow row: Int, column: Int) -> GamePiece? {
        guard isRowInBound(row) && isColumnInBound(column) else {
            return nil
        }
        
        return board[row][column]
    }
    
    /// Check whether the board has a dertemined winning piece on the board
    /// - Returns: `true` if the board has a winning piece, `false` otherwise
    func hasWinningPiece() -> Bool {
        guard let candidate = lastPlacedPiece,
            numberOfPlacedPiece >= 5 else {
                // fix the hard-coded value of 5 later
                return false
        }
        
        let index = board.flatMap { $0 }
            .index(of: candidate)!
        
        // check winning condition on row
        let row = index / size
        if piecesAtRow(row).allEqualTo(candidate) {
            return true
        }
        
        // check winning condition on column
        let column = index % size
        if piecesAtColumn(column).allEqualTo(candidate) {
            return true
        }
        
        // check winning condition on left-to-right diagonal
        if row == column && piecesAtLeftToRightDiagonal().allEqualTo(candidate) {
            return true
        }
        
        // check winning condition on right-to-left diagonal
        if row == (size - 1 - column) && piecesAtRightToLeftDiagonal().allEqualTo(candidate) {
            return true
        }
        
        return false
    }
    
    /// Check whether the board has ended with a draw.
    /// In other words the board has no empty, placeable locations but neither
    /// two pieces are winner
    /// - Returns: `true` if the board has ended with a draw, `false` otherwise
    func isDrawEnding() -> Bool {
        return numberOfPlacedPiece == size * size && !hasWinningPiece()
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
    
    // Return the collection of game pieces on given row
    private func piecesAtRow(_ row: Int) -> [GamePiece?] {
        precondition(isRowInBound(row), "The row is out of bound!")
        
        return board[row]
    }
    
    // Return the collection of game pieces on given column
    private func piecesAtColumn(_ column: Int) -> [GamePiece?] {
        precondition(isColumnInBound(column), "The column is out of bound!")
        
        return board.map { $0[column] }
    }
    
    // Return the collection of game pieces on the left-to-right diagonal
    private func piecesAtLeftToRightDiagonal() -> [GamePiece?] {
        return board.enumerated().map { $1[$0] }
    }
    
    // Return the collection of game pieces on the right-to-left diagonal
    private func piecesAtRightToLeftDiagonal() -> [GamePiece?] {
        return board.enumerated().map { $1[size - 1 - $0] }
    }
}
