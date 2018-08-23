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
    
    lazy var gameBoardView: GameBoardView = {
        let view = GameBoardView(size: 3)
        
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
        view.addSubview(gameBoardView)
        
        gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameBoardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameBoardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            gameBoardView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            gameBoardView.heightAnchor.constraint(equalTo: gameBoardView.widthAnchor)])
        
        gameBoardView.delegate = self
    }
    
    @objc private func menuBarButtonPressed(_ sender: UIBarButtonItem) {
        // implement later
    }
    
    // Update subviews to reflect changes of model
    // -------------------------------------------
    
    private func updateView() {
        // update the gameBoard as currentGameBoard has been mutated
        for row in 0..<currentGameBoard.size {
            for column in 0..<currentGameBoard.size {
                if let gamePieceView = gameBoardView.gamePieceView(atRow: row, column: column) {
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
}

// MARK: - GameBoardView Delegte

extension GameViewController: GameBoardViewDelegate {
    
    func gameBoardView(_ gameBoardView: GameBoardView, didTap gamePieceView: GamePieceView, atRow row: Int, column: Int) {
        guard !currentGameBoard.hasWinningPiece() && !currentGameBoard.isDrawEnding() else {
            return
        }
        
        do {
            try currentGameBoard.placeNextPiece(toRow: row, column: column)
            updateView()
        } catch {
            // since we've checked currentGameBoard is ended (win or draw) above,
            // this only catches when user try to tap the already-tapped game piece view
            return
        }
    }
}
