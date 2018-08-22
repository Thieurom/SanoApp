//
//  GamePieceSelectionView.swift
//  Three
//
//  Created by Doan Le Thieu on 8/21/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GamePieceSelectionView: UIView {
    
    private struct Dimension {
        static let labelFontSize: CGFloat = 14.0
        static let pieceViewScale: CGFloat = 3 / 7
        static let buttonSize: CGFloat = 40.0
        static let spacing: CGFloat = 40.0
    }
    
    private var leftLabel: UILabel!
    private var rightLabel: UILabel!
    private var leftPiece: GamePieceView!
    private var rightPiece: GamePieceView!
    private var switchButton: UIButton!
    
    // MARK: - Pulic
    
    /// Check whether the pieces are on the right order or not.
    /// The rule: the right order is in which the solid black piece view is on the left,
    /// the donut black one is on the right.
    /// - Returns: `true` if is on the right order, `else` otherwise
    var isOnRightOrder: Bool = true {
        didSet {
            leftPiece.style = isOnRightOrder ? .solidBlack : .donutBlack
            rightPiece.style = isOnRightOrder ? .donutBlack : .solidBlack
        }
    }
    
    /// Set the order of the pieces
    /// - Parameter rightOrder: `true` if the order should be turned to the right order,
    /// `false` if the order should be turned to the reversed order.
    func setRightOrder(_ rightOrder: Bool) {
        isOnRightOrder = rightOrder
    }
    
    // MARK: - Initialization
    
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
    
    convenience init(titleOne: String, titleTwo: String) {
        self.init(frame: CGRect.zero)
        
        self.leftLabel.text = titleOne
        self.rightLabel.text = titleTwo
    }
    
    // MARK: - Private helpers
    
    private func initSubviews() {
        leftLabel = UILabel()
        leftLabel.text = "Piece One"
        leftLabel.textAlignment = .center
        leftLabel.font = UIFont.systemFont(ofSize: Dimension.labelFontSize, weight: .bold)
        
        rightLabel = UILabel()
        rightLabel.text = "Piece Two"
        rightLabel.textAlignment = .center
        rightLabel.font = UIFont.systemFont(ofSize: Dimension.labelFontSize, weight: .bold)
        
        leftPiece = GamePieceView()
        leftPiece.backgroundColor = .white
        leftPiece.style = isOnRightOrder ? .solidBlack : .donutBlack
        
        rightPiece = GamePieceView()
        rightPiece.backgroundColor = .white
        rightPiece.style = isOnRightOrder ? .donutBlack : .solidBlack
        
        switchButton = UIButton()
        switchButton.setBackgroundImage(UIImage(named: "switch_button"), for: .normal)
        switchButton.addTarget(self, action: #selector(switchButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(leftPiece)
        addSubview(rightPiece)
        addSubview(switchButton)
    }
    
    private func constraintSubviews() {
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        leftPiece.translatesAutoresizingMaskIntoConstraints = false
        rightPiece.translatesAutoresizingMaskIntoConstraints = false
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: self.topAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: leftPiece.trailingAnchor)])
        
        leftLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        leftLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        
        NSLayoutConstraint.activate([
            rightLabel.topAnchor.constraint(equalTo: self.topAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: rightPiece.leadingAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        rightLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        rightLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        
        NSLayoutConstraint.activate([
            leftPiece.topAnchor.constraint(equalTo: leftLabel.bottomAnchor, constant: Dimension.spacing),
            leftPiece.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftPiece.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Dimension.pieceViewScale),
            leftPiece.heightAnchor.constraint(equalTo: leftPiece.widthAnchor)])
        
        NSLayoutConstraint.activate([
            rightPiece.topAnchor.constraint(equalTo: rightLabel.bottomAnchor, constant: Dimension.spacing),
            rightPiece.centerYAnchor.constraint(equalTo: leftPiece.centerYAnchor),
            rightPiece.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightPiece.widthAnchor.constraint(equalTo: leftPiece.widthAnchor),
            rightPiece.heightAnchor.constraint(equalTo: leftPiece.widthAnchor)])
        
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: leftPiece.bottomAnchor, constant: Dimension.spacing),
            switchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            switchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            switchButton.widthAnchor.constraint(equalToConstant: Dimension.buttonSize),
            switchButton.heightAnchor.constraint(equalToConstant: Dimension.buttonSize)])
    }
    
    @objc private func switchButtonPressed(_ sender: UIButton) {
        isOnRightOrder = !isOnRightOrder
    }
}
