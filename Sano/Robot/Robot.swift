//
//  Robot.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/31/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/// A Robot can play a perfect game of TicTacToe (to win or at least, draw),
/// using the Minimax algorithm (https://en.wikipedia.org/wiki/Minimax)
class Robot {
    
    // the score used when evaluating game board
    private static let baseScore = 10
    
    /// The playing piece of robot
    var playingPiece: GamePiece
    
    /// Create the new robot
    ///
    /// - Parameter playingPiece: robot's playing piece
    /// - Returns: new robot
    init(playingPiece: GamePiece) {
        self.playingPiece = playingPiece
    }
    
    typealias Location = (row: Int, column: Int)
    
    /// Play the game board by returning the next location on the game board
    ///
    /// - Parameter gameBoard: the game board is being played
    /// - Returns: a `Location` aka (row, column)
    /// or `nil` if robot is not the next player or game board is completed
    func play(gameBoard: GameBoard) -> Location? {
        guard gameBoard.nextPlacingPiece == playingPiece else {
            return nil
        }
        
        if let location = openingLocation(gameBoard: gameBoard) {
            return location
        }
        
        return minimax(gameBoard: gameBoard, depth: 0).location
    }
}

// MARK: - Algorithms

extension Robot {
    
    private typealias Move = (location: Location?, score: Int)
    
    // the main algorithms
    private func minimax(gameBoard: GameBoard, depth: Int) -> Move {
        // base case
        if isGameBoardCompleted(gameBoard) {
            let score = evaluate(gameBoard: gameBoard, at: depth)
            return (nil, score)
        }
        
        // get all possible locations to be played at current depth of the game board
        let locations = emptyLocations(of: gameBoard)
        
        // calculate score for each possible locations
        let scores: [Int] = locations.map { location in
            do {
                // we need to create a copy of current game board before mutating it
                var board = gameBoard
                
                try board.placeNextPiece(toRow: location.row, column: location.column)
                return minimax(gameBoard: board, depth: depth + 1).score
            } catch {
                fatalError()
            }
        }
        
        let minIndex = scores.index(of: scores.min()!)!
        let maxIndex = scores.index(of: scores.max()!)!
        
        // get the best index depending on which piece is going to play
        let bestIndex = (gameBoard.nextPlacingPiece == playingPiece) ? maxIndex : minIndex
        
        return (locations[bestIndex], scores[bestIndex])
    }
    
    // evaluate the game board at given depth by scoring
    private func evaluate(gameBoard: GameBoard, at depth: Int) -> Int {
        if gameBoard.hasWinningPiece() {
            if gameBoard.lastPlacedPiece == playingPiece {
                return Robot.baseScore - depth
            } else {
                return -Robot.baseScore + depth
            }
        } else {
            return 0
        }
    }
}

// MARK: - Helpers

extension Robot {
    
    private func isGameBoardCompleted(_ gameBoard: GameBoard) -> Bool {
        return gameBoard.hasWinningPiece() || gameBoard.isDrawEnding()
    }
    
    private func emptyLocations(of gameBoard: GameBoard) -> [Location] {
        var locations = [Location]()
        
        for row in 0..<gameBoard.size {
            for column in 0..<gameBoard.size {
                if gameBoard.piece(atRow: row, column: column) == nil {
                    locations.append((row, column))
                }
            }
        }
        
        return locations
    }
    
    private func openingLocation(gameBoard: GameBoard) -> Location? {
        guard emptyLocations(of: gameBoard).count == gameBoard.size * gameBoard.size else {
            return nil
        }

        let boundIndex = gameBoard.size - 1
        let cornerLocations: [Location] = [(0, 0), (0, boundIndex), (boundIndex, 0), (boundIndex, boundIndex)]
        
        let randomIndex = Int(arc4random_uniform(UInt32(cornerLocations.count)))
        
        return cornerLocations[randomIndex]
    }
}
