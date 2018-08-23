//
//  GameBoardView.swift
//  Three
//
//  Created by Doan Le Thieu on 8/22/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

protocol GameBoardViewDelegate: AnyObject {
    func gameBoardView(_ gameBoardView: GameBoardView, didTap gamePieceView: GamePieceView, atRow row: Int, column: Int)
}

/// Represent the square game board, with size x size squares as GamePieceView
class GameBoardView: UIView {
    
    private let size: Int
    
    private var containerView: UIStackView!
    
    weak var delegate: GameBoardViewDelegate?
    
    // MARK: - Initialization

    init(size: Int) {
        self.size = size
        super.init(frame: CGRect.zero)
        
        initSubviews()
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension GameBoardView {
    
    func gamePieceView(atRow row: Int, column: Int) -> GamePieceView? {
        guard row >= 0 && row < size && column >= 0 && column < size else {
            return nil
        }
        
        let gamePieceViewCollection = containerView.subviews.flatMap { $0.subviews }
        let index = row * size + column
        
        return gamePieceViewCollection[index] as? GamePieceView
    }
}

// MARK: - Private helpers

extension GameBoardView {
    
    private func initSubviews() {
        containerView = UIStackView()
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.distribution = .fillEqually
        containerView.spacing = 10
        
        for _ in 0..<size {
            let rowContainerView = UIStackView()
            
            rowContainerView.axis = .horizontal
            rowContainerView.alignment = .fill
            rowContainerView.distribution = .fillEqually
            rowContainerView.spacing = 10
            
            for _ in 0..<size {
                let gamePieceView = GamePieceView()
                gamePieceView.backgroundColor = .white
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gamePieceViewTapped(_:)))
                gamePieceView.addGestureRecognizer(tapGestureRecognizer)
                rowContainerView.addArrangedSubview(gamePieceView)
            }
            
            containerView.addArrangedSubview(rowContainerView)
        }
    }
    
    private func addSubviews() {
        addSubview(containerView)
    }
    
    private func constraintSubviews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    @objc private func gamePieceViewTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        guard let gamePieceView = tapGestureRecognizer.view as? GamePieceView else {
            return
        }
        
        let gamePieceViewCollection = containerView.subviews.flatMap { $0.subviews }
        
        guard let index = gamePieceViewCollection.index(of: gamePieceView) else {
            return
        }

        let row = index / size
        let column = index % size

        delegate?.gameBoardView(self, didTap: gamePieceView, atRow: row, column: column)
    }
}
