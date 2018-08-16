//
//  GamePiece.swift
//  Three
//
//  Created by Doan Le Thieu on 8/16/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/// Represent the piece which is played in a game
enum GamePiece {
    
    // There are only two types of pieces: solid and donut,
    // (equivalent to cross and nought in classical tic-tac-toe)
    case solid
    case donut
    
    /// Return the other piece of reiceiver (given that there're only two types of pieces)
    var opposite: GamePiece {
        switch self {
        case .solid:
            return .donut
        case .donut:
            return .solid
        }
    }
}

extension GamePiece: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .solid:
            return "●"
        case .donut:
            return "○"
        }
    }
}
