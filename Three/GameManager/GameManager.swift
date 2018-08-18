//
//  GameManager.swift
//  Three
//
//  Created by Doan Le Thieu on 8/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/// Manage the game.
/// It is responsible to create new game board with the first piece according to
/// game rule (as below).
/// It manages all played game boards by send it valid-first-playing-piece and completed
/// game boards by `addCompletedBoard(:)`
/// It can also can report how many game boards that played to the completion,
/// how many wins for each piece.
///
/// Rule:
/// - the first piece for the first game board is given when initializing the game object
/// - the first piece for the next game board depends on the result of the
/// previous one: if ends with a winning, the first piece of the previous game board
/// continue play first; if ends with a draw, switch.
class GameManager {
    
    /// The size of all boards that being played during a game
    let boardSize: Int
    
    /// The first playing piece of the firstly-created game board
    let firstPlayingPiece: GamePiece
    
    // Contain all boards that are completed (end with winning or draw)
    private var playedBoards = [GameBoard]()
    
    /// Create new game object to manage the game
    /// - Parameters:
    ///     - boardSize: the size of the game board
    ///     - firstPlayingPiece: the first playing piece of the first played game board
    /// - Returns: new game object
    init(boardSize: Int, firstPlayingPiece: GamePiece) {
        self.boardSize = boardSize
        self.firstPlayingPiece = firstPlayingPiece
    }
}

extension GameManager {
    
    /// Return the number of completed boards that it currently manages
    var numberOfPlayedBoards: Int {
        return playedBoards.count
    }
    
    /// Return the first piece of the new game board
    var firstPieceOfNewGameBoard: GamePiece {
        // if there isn't any played board yet
        // the first piece of new (first) board is the one given when initializtion
        guard let lastBoard = playedBoards.last else {
            return firstPlayingPiece
        }
        
        // if the last board ends with a win, the winning piece will be
        // the first playing piece of next board
        if lastBoard.hasWinningPiece() {
            return lastBoard.lastPlacedPiece!
        }
        
        // up to this, the last board ends with a draw, so just switch the piece
        return lastBoard.firstPiece.opposite
    }
}

extension GameManager {
    
    /// Create new game board with the first piece according to game rule
    func newBoard() -> GameBoard {
        return GameBoard(size: boardSize, firstPiece: firstPieceOfNewGameBoard)
    }
    
    /// Add a completed game board to be managed by the game object
    ///
    /// - Parameter board: the board that wishes to be managed by the game
    /// - Throws:
    ///     - `GameManagerError.invalidFirstPlayingPiece` if given board's first piece does
    /// not match by the game rule
    ///     - `GameManagerError.incompletedBoard` if the board still be able to
    /// play
    func addCompletedBoard(_ board: GameBoard) throws {
        guard board.firstPiece == firstPlayingPiece else {
            throw GameManagerError.invalidFirsPlayingPiece
        }
        
        guard board.hasWinningPiece() || board.isDrawEnding() else {
            throw GameManagerError.incompleteBoard
        }
        
        playedBoards.append(board)
    }
    
    /// Return the number of winning by a specified piece of all played game boards
    /// - Parameter gamePiece: the piece
    /// - Returns: The number of winning
    func winningCount(by gamePiece: GamePiece) -> Int {
        return playedBoards.reduce(0, { (totalWins, board) -> Int in
            let win = (board.hasWinningPiece() && board.lastPlacedPiece! == gamePiece) ? 1 : 0
            return totalWins + win
        })
    }
}
