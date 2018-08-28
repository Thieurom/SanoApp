//
//  GameViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/22/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Data
    
    let gameManager: GameManager
    var currentGameBoard: GameBoard!
    
    // MARK: - Views
    
    lazy var gameScoringView: ScoringView = {
        let view = ScoringView(playerOneName: "SOLID", playerTwoName: "DONUT")
        view.backgroundColor = .black
        view.textColor = .white
        
        return view
    }()
    
    lazy var gameView: GameView = {
        let view = GameView()
        return view
    }()
    
    // MARK: Initialization
    
    init(gameManager: GameManager) {
        self.gameManager = gameManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        setUpSubviews()
        
        currentGameBoard = gameManager.newBoard()
        
        updateGameScoringView()
        updateGameView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private helpers

extension GameViewController {
    
    // Subview configuration
    // ---------------------
    
    // Further config the root view since it will be created programmatically
    private func configView() {
        view.backgroundColor = .white
        
        // customize navigationBar for this and will-be-pushed view controllers
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // this will change status bar to light content
        navigationController?.navigationBar.barStyle = .black
        
        // add menu button
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu_bar_button"), style: .plain, target: self, action: #selector(menuBarButtonPressed(_:)))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    private func setUpSubviews() {
        // add subviews to view hierarchy
        view.addSubview(gameScoringView)
        view.addSubview(gameView)
        
        // constraint subviews
        gameScoringView.translatesAutoresizingMaskIntoConstraints = false
        gameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameScoringView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameScoringView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameScoringView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: gameScoringView.bottomAnchor, constant: 20),
            gameView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
        
        // further config
        gameView.gameBoardView.delegate = self
        gameView.playNewGameBoardButton.addTarget(self, action: #selector(playNewGameBoardButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func playNewGameBoardButtonPressed(_ sender: UIButton) {
        gameView.hidePlayNewGameBoardButton { [unowned self] () in
            self.currentGameBoard = self.gameManager.newBoard()
            self.updateGameView()
        }
    }
    
    @objc private func menuBarButtonPressed(_ sender: UIBarButtonItem) {
        let menuViewController = MenuViewController(transitioningAnimated: true)
        menuViewController.modalPresentationStyle = .overFullScreen
        
        present(menuViewController, animated: true, completion: nil)
    }
    
    // Update subviews to reflect changes of model
    // -------------------------------------------
    
    private func updateGameView() {
        updateGameBoardView()
        updateCommentaryView()
        
        if currentGameBoard.hasWinningPiece() || currentGameBoard.isDrawEnding() {
            gameView.showPlayNewGameBoardButton()
        }
    }
    
    private func updateGameBoardView() {
        // update the gameBoard as currentGameBoard has been mutated
        for row in 0..<currentGameBoard.size {
            for column in 0..<currentGameBoard.size {
                if let gamePieceView = gameView.gameBoardView.gamePieceView(atRow: row, column: column) {
                    let gamePiece = currentGameBoard.piece(atRow: row, column: column)
                    
                    switch gamePiece {
                    case .some(.solid):
                        gamePieceView.style = .solidBlack
                    case .some(.donut):
                        gamePieceView.style = .donutBlack
                    default:
                        gamePieceView.style = .solidGray
                    }
                }
            }
        }
    }
    
    private func updateCommentaryView() {
        if currentGameBoard.hasWinningPiece() {
            let winner = (currentGameBoard.lastPlacedPiece!).rawValue.uppercased()
            gameView.gameCommentaryView.setComment("\(winner) WON!")
        } else if currentGameBoard.isDrawEnding() {
            gameView.gameCommentaryView.setComment("IT'S A DRAW!")
        } else {
            let nextPiece = (currentGameBoard.nextPlacingPiece).rawValue.capitalized
            gameView.gameCommentaryView.setComment("\(nextPiece) moves!")
        }
    }
    
    private func updateGameScoringView() {
        gameScoringView.setPlayerOneScore(gameManager.winningCount(by: .solid))
        gameScoringView.setPlayerTwoScore(gameManager.winningCount(by: .donut))
    }
}

// MARK: - GameBoardView Delegte

extension GameViewController: GameBoardViewDelegate {
    
    func gameBoardView(_ gameBoardView: GameBoardView, didTap gamePieceView: GamePieceView, atRow row: Int, column: Int) {
        guard !currentGameBoard.hasWinningPiece() && !currentGameBoard.isDrawEnding() else {
            return
        }
        
        do {
            try currentGameBoard.placeNextPiece(toRow: row, column: column)
            updateGameView()
            
            if currentGameBoard.hasWinningPiece() || currentGameBoard.isDrawEnding() {
                do {
                    try gameManager.addCompletedBoard(currentGameBoard)
                    updateGameScoringView()
                } catch {
                    return
                }
            }
        } catch {
            // since we've checked currentGameBoard is ended (win or draw) above,
            // this only catches when user try to tap the already-tapped game piece view
            return
        }
    }
}
