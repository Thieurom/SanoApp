//
//  GameBoardError.swift
//  Three
//
//  Created by Doan Le Thieu on 8/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/// Various errors that can be used to throw when try to mutate the board
enum GameBoardError: Error {
    case outOfBoard
    case notEmptyLocation
}
