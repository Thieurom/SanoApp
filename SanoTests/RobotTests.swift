//
//  RobotTests.swift
//  SanoTests
//
//  Created by Doan Le Thieu on 8/31/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

// swiftlint:disable file_length
import XCTest
@testable import Sano

class RobotTests: XCTestCase {
    
    var robot: Robot!
    var board: GameBoard!
    
    override func setUp() {
        super.setUp()
        
        robot = Robot(playingPiece: .donut)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPlayingPiece() {
        XCTAssertEqual(robot.playingPiece, .donut, "The robot's playing piece should be donut!")
        
        robot.playingPiece = .solid
        XCTAssertEqual(robot.playingPiece, .solid, "The robot's playing piece should be solid!")
    }
    
    func testPlayWhenIncorrectPlayer() {
        board = GameBoard(size: 3, firstPiece: .solid)
        let location = robot.play(gameBoard: board)
        
        XCTAssertNil(location, "The location should be nil when playing wrong order!")
    }
    
    func testPlayWinningGameBoard() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ○ | ○ | ● |
                |---|---|---|
             1  |   | ● |   |
                |---|---|---|
             2  | ● |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 2), (0, 0), (1, 1), (0, 1), (2, 0))
        } catch {
            fatalError()
        }
        
        let location = robot.play(gameBoard: board)
        
        XCTAssertNil(location, "The location should be nil when playing to a winning board!")
    }
    
    func testPlayWithDrawingGameBoard() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ | ● |
                |---|---|---|
             1  | ● | ○ | ○ |
                |---|---|---|
             2  | ○ | ● | ● |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (2, 0), (0, 2), (1, 1), (2, 1), (1, 2), (2, 2))
        } catch {
            fatalError()
        }
        
        let location = robot.play(gameBoard: board)
        
        XCTAssertNil(location, "The location should be nil when playing to a drawing board!")
    }
    
    func testPlayOpeningMove() {
        board = GameBoard(size: 3, firstPiece: .donut)
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the empty board!")
            return
        }
        
        let cornerLocations: [(Int, Int)] = [(0, 0), (0, 2), (2, 0), (2, 2)]
        
        XCTAssertTrue(cornerLocations.contains { $0.0 == location.0 && $0.1 == location.1 }, "The opening move should be one of four corner locations of the board, not: \(location)")
    }
    
    func testPlayAfterTopLeftCornerOpeningMove() {
        do {
            /*
                 0   1   2
                .___.___.___.
             0  | ● |   |   |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 1 && location.column == 1, "The robot should play at the center after corner opening move, not: \(location)")
    }
    
    func testPlayAfterTopRightCornerOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   | ● |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 2))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 1 && location.column == 1, "The robot should play at the center after corner opening move, not: \(location)")
    }
    
    func testPlayAfterBottomLeftCornerOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  | ● |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (2, 0))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 1 && location.column == 1, "The robot should play at the center after corner opening move")
    }
    
    func testPlayAfterBottomRightCornerOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  |   |   | ● |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (2, 2))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 1 && location.column == 1, "The robot should play at the center after corner opening move, not: \(location)")
    }
    
    func testPlayAfterCenterOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  |   | ● |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (1, 1))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 0 && location.column == 0, "The robot should play at the first corner after center opening move, not: \(location)")
    }
    
    func testPlayAfterTopMiddleEdgeOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   | ● |   |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 1))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        let bestLocations: [(Int, Int)] = [(0, 0), (0, 2), (1, 1), (2, 1)]
        
        XCTAssertTrue(bestLocations.contains { $0.0 == location.row && $0.1 == location.column }, "The robot should play at the first location of: 2 adjacent corners, center, opposite middle edge to the middle edge opening move, not at: \(location)")
    }
    
    func testPlayAfterLeftMiddleEdgeOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  | ● |   |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (1, 0))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        let bestLocations: [(Int, Int)] = [(0, 0), (1, 1), (1, 2), (2, 0)]
        
        XCTAssertTrue(bestLocations.contains { $0.0 == location.row && $0.1 == location.column }, "The robot should play at the first location of: 2 adjacent corners, center, opposite middle edge to the middle edge opening move, not at: \(location)")
    }
    
    func testPlayAfterRightMiddleEdgeOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  |   |   | ● |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (1, 2))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        let bestLocations: [(Int, Int)] = [(0, 2), (1, 0), (1, 1), (2, 2)]
        
        XCTAssertTrue(bestLocations.contains { $0.0 == location.row && $0.1 == location.column }, "The robot should play at the first location of: 2 adjacent corners, center, opposite middle edge to the middle edge opening move, not at: \(location)")
    }
    
    func testPlayAfterBottomMiddleEdgeOpeningMove() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  |   |   |   |
                |---|---|---|
             1  |   |   |   |
                |---|---|---|
             2  |   | ● |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (2, 1))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        let bestLocations: [(Int, Int)] = [(0, 1), (1, 1), (2, 0), (2, 2)]
        
        XCTAssertTrue(bestLocations.contains { $0.0 == location.row && $0.1 == location.column }, "The robot should play at the first location of: 2 adjacent corners, center, opposite middle edge to the middle edge opening move, not at: \(location)")
    }
    
    func testPlayToBlockImmediately() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ |   |
                |---|---|---|
             1  | ● |   |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 2 && location.column == 0, "The robot should play to block opponent at (2, 0), not at: \(location)")
    }
    
    func testPlayToWinOnFirstChance() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ |   |
                |---|---|---|
             1  | ● | ○ |   |
                |---|---|---|
             2  |   |   |   |
                '---'---'---'
             */
            
            // robot play first with solid
            robot.playingPiece = .solid
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (1, 1))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 2 && location.column == 0, "The robot should play at the winning location, not at: \(location)")
    }
    
    func testPlayToWinGameBoardRemainTwoLocations() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ● | ○ |
                |---|---|---|
             1  | ● | ● | ○ |
                |---|---|---|
             2  | ○ |   |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 2), (1, 0), (2, 0), (0, 1), (1, 2), (1, 1))
            
        } catch {
            fatalError()
        }

        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 2 && location.column == 2, "The robot should play at the winning location at (2, 2), not at: \(location)")
    }
    
    func testPlayToBlockOpponentGameBoardRemainTwoLocations() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ | ● |
                |---|---|---|
             1  | ○ | ○ | ● |
                |---|---|---|
             2  |   | ● |   |
                '---'---'---'
             */
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (0, 2), (1, 0), (2, 1), (1, 1), (1, 2))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }
        
        XCTAssertTrue(location.row == 2 && location.column == 2, "The robot should should play to block opponent to win at (2, 2), not at: \(location)")
    }
    
    func testPlayGameBoardRemainOneLocation() {
        do {
            /*
                  0   1   2
                .___.___.___.
             0  | ● | ○ |   |
                |---|---|---|
             1  | ● | ○ | ○ |
                |---|---|---|
             2  | ○ | ● | ● |
                '---'---'---'
             */
            
            // robot play first with solid
            robot.playingPiece = .solid
            
            board = try GameBoardTests.makeGameBoard(firstPiece: .solid, filledWithLocations: (0, 0), (0, 1), (1, 0), (2, 0), (2, 1), (1, 1), (2, 2), (1, 2))
            
        } catch {
            fatalError()
        }
        
        guard let location = robot.play(gameBoard: board) else {
            XCTFail("The robot should be able to play on the valid board!")
            return
        }

        XCTAssertTrue(location.row == 0 && location.column == 2, "The robot should play at the last valid location of the game board at (0, 2, not at: \(location)")
    }
    
    func testRobotVersusRobotAlwaysDraw() {
        let secondRobot = Robot(playingPiece: .solid)
        
        var completedBoards = [GameBoard]()
        let numberOfPlayingBoards = 10
        
        for _ in 0..<numberOfPlayingBoards {
            var board = GameBoard(size: 3, firstPiece: .donut)
            
            while !board.hasWinningPiece() && !board.isDrawEnding() {
                var location: (Int, Int)?
                
                if board.nextPlacingPiece == .donut {
                    location = robot.play(gameBoard: board)
                } else {
                    location = secondRobot.play(gameBoard: board)
                }
                
                do {
                    try board.placeNextPiece(toRow: location!.0, column: location!.1)
                } catch {
                    fatalError()
                }
            }
            
            completedBoards.append(board)
        }
        
        XCTAssertEqual(completedBoards.count, numberOfPlayingBoards)
        
        let numberOfDrawingBoards: Int = completedBoards.reduce(0, { (total, board) in
            return total + (board.isDrawEnding() ? 1 : 0)
        })
        
        XCTAssertEqual(numberOfDrawingBoards, numberOfPlayingBoards, "All the boards have been played between 2 robots should be ended with a draw!")
    }
}
