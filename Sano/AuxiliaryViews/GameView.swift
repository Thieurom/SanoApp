//
//  GameView.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/25/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    private struct Dimension {
        static let spacing: CGFloat = 20
        static let buttonSize: CGFloat = 40
    }
    
    private(set) var gameBoardView: GameBoardView!
    private(set) var gameCommentaryView: CommentaryView!
    private(set) var playNewGameBoardButton: UIButton!
    
    private var buttonBottomConstraint: NSLayoutConstraint!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
        addSubviews()
        constraintSubviews()
    }
}

// MARK: - Public interface

extension GameView {
    
    func showPlayNewGameBoardButton() {
        buttonBottomConstraint.constant = -Dimension.spacing
        playNewGameBoardButton.isEnabled = true
        
        UIView.animate(withDuration: 0.25) {
            self.playNewGameBoardButton.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    func hidePlayNewGameBoardButton(completion: @escaping () -> Void) {
        buttonBottomConstraint.constant = -2 * Dimension.spacing
        playNewGameBoardButton.isEnabled = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.gameBoardView.alpha = 0
            self.playNewGameBoardButton.alpha = 0
            self.layoutIfNeeded()
        }, completion: { (_) in
            completion()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.gameBoardView.alpha = 1
            })
        })
    }
}

// MARK: - Private helpers

extension GameView {
    
    private func initSubviews() {
        gameBoardView = GameBoardView(size: 3)
        
        playNewGameBoardButton = UIButton()
        playNewGameBoardButton.setBackgroundImage(UIImage(named: "play_new_button"), for: .normal)
        
        gameCommentaryView = CommentaryView()
    }
    
    private func addSubviews() {
        addSubview(gameBoardView)
        
        // to show and hide playNewGameBoardButton from under gameBoardView
        insertSubview(playNewGameBoardButton, belowSubview: gameBoardView)
        
        addSubview(gameCommentaryView)
    }
    
    private func constraintSubviews() {
        gameCommentaryView.translatesAutoresizingMaskIntoConstraints = false
        gameBoardView.translatesAutoresizingMaskIntoConstraints = true
        playNewGameBoardButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameCommentaryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gameCommentaryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gameCommentaryView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        NSLayoutConstraint.activate([
            playNewGameBoardButton.widthAnchor.constraint(equalToConstant: Dimension.buttonSize),
            playNewGameBoardButton.heightAnchor.constraint(equalToConstant: Dimension.buttonSize),
            playNewGameBoardButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        
        buttonBottomConstraint = playNewGameBoardButton.bottomAnchor.constraint(equalTo: gameCommentaryView.topAnchor)
        buttonBottomConstraint.isActive = true
        
        // initially hide button
        buttonBottomConstraint.constant = -2 * Dimension.spacing
        playNewGameBoardButton.alpha = 0
        playNewGameBoardButton.isEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let bottomHeight = gameCommentaryView.bounds.height
        var maxHeight = bounds.height - (bottomHeight + Dimension.spacing)
        
        if buttonBottomConstraint.constant == -Dimension.spacing {
            maxHeight -= Dimension.buttonSize + Dimension.spacing
        }
        
        let height = maxHeight - 2 * Dimension.spacing
        let size = min(bounds.width, height)
        
        gameBoardView.frame = CGRect(x: (bounds.width - size) / 2, y: (maxHeight - size) / 2, width: size, height: size)
    }
}
