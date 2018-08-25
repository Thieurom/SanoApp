//
//  CommentaryView.swift
//  Three
//
//  Created by Doan Le Thieu on 8/25/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class CommentaryView: UIView {
    
    private struct Dimension {
        static let borderWidth: CGFloat = 4
        static let labelFontSize: CGFloat = 18
        static let boundsHeight: CGFloat = 60
    }
    
    private var topBorderLineView: UIView!
    private var bottomBorderLineView: UIView!
    private var commentaryLabel: UILabel!
    
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
}

// MARK: - Public

extension CommentaryView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Dimension.boundsHeight)
    }
    
    func setComment(_ comment: String) {
        commentaryLabel.text = comment
    }
}

// MARK: - Private

extension CommentaryView {
    
    private func initSubviews() {
        topBorderLineView = UIView()
        topBorderLineView.backgroundColor = .black
        
        bottomBorderLineView = UIView()
        bottomBorderLineView.backgroundColor = .black
        
        commentaryLabel = UILabel()
        commentaryLabel.text = "Comment"
        commentaryLabel.textAlignment = .center
        commentaryLabel.textColor = .black
        commentaryLabel.font = UIFont.systemFont(ofSize: Dimension.labelFontSize, weight: .bold)
    }
    
    private func addSubviews() {
        addSubview(topBorderLineView)
        addSubview(bottomBorderLineView)
        addSubview(commentaryLabel)
    }
    
    private func constraintSubviews() {
        topBorderLineView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderLineView.translatesAutoresizingMaskIntoConstraints = false
        commentaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBorderLineView.heightAnchor.constraint(equalToConstant: Dimension.borderWidth),
            topBorderLineView.topAnchor.constraint(equalTo: self.topAnchor),
            topBorderLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBorderLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            bottomBorderLineView.heightAnchor.constraint(equalToConstant: Dimension.borderWidth),
            bottomBorderLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorderLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorderLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            commentaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            commentaryLabel.topAnchor.constraint(equalTo: topBorderLineView.bottomAnchor),
            commentaryLabel.bottomAnchor.constraint(equalTo: bottomBorderLineView.topAnchor)])
    }
}
