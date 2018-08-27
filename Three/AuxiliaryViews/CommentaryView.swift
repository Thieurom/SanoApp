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
    private var nextCommentaryLabel: UILabel!
    
    private var commentaryLabelLeadingConstraint: NSLayoutConstraint!
    private var commentaryLabelTrailingConstraint: NSLayoutConstraint!
    private var nextCommentaryLabelLeadingConstraint: NSLayoutConstraint!
    private var nextCommentaryLabelTrailingConstraint: NSLayoutConstraint!
    
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
        nextCommentaryLabel.text = comment
        
        // force any outstanding layout changes
        layoutIfNeeded()
        
        // push commentaryLabel off the left, show the nextCommentary
        commentaryLabelTrailingConstraint.isActive = false
        nextCommentaryLabelTrailingConstraint.isActive = true
        
        UIView.animate(withDuration: 0.25, animations: {
            self.commentaryLabel.alpha = 0
            self.nextCommentaryLabel.alpha = 1
            
            self.layoutIfNeeded()
        }, completion: { (_) in
            swap(&self.commentaryLabel, &self.nextCommentaryLabel)
            swap(&self.commentaryLabelLeadingConstraint, &self.nextCommentaryLabelLeadingConstraint)
            swap(&self.commentaryLabelTrailingConstraint, &self.nextCommentaryLabelTrailingConstraint)
            
            // move the nextCommentaryLabel off the right
            self.commentaryLabelLeadingConstraint.isActive = false
            self.nextCommentaryLabelLeadingConstraint.isActive = true
        })
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
        commentaryLabel.textAlignment = .center
        commentaryLabel.textColor = .black
        commentaryLabel.font = UIFont.systemFont(ofSize: Dimension.labelFontSize, weight: .bold)
        commentaryLabel.alpha = 1
        
        nextCommentaryLabel = UILabel()
        nextCommentaryLabel.textAlignment = .center
        nextCommentaryLabel.textColor = .black
        nextCommentaryLabel.font = UIFont.systemFont(ofSize: Dimension.labelFontSize, weight: .bold)
        nextCommentaryLabel.alpha = 0
    }
    
    private func addSubviews() {
        addSubview(topBorderLineView)
        addSubview(bottomBorderLineView)
        addSubview(commentaryLabel)
        addSubview(nextCommentaryLabel)
    }
    
    private func constraintSubviews() {
        topBorderLineView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderLineView.translatesAutoresizingMaskIntoConstraints = false
        commentaryLabel.translatesAutoresizingMaskIntoConstraints = false
        nextCommentaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            commentaryLabel.topAnchor.constraint(equalTo: topBorderLineView.bottomAnchor),
            commentaryLabel.bottomAnchor.constraint(equalTo: bottomBorderLineView.topAnchor),
            commentaryLabel.widthAnchor.constraint(equalTo: self.widthAnchor)])
        
        // to make commentaryLabel being on the right of nextCommentLabel
        commentaryLabelLeadingConstraint = commentaryLabel.leadingAnchor.constraint(equalTo: nextCommentaryLabel.trailingAnchor)
        
        // to make commentaryLabel occupy superview
        commentaryLabelTrailingConstraint = commentaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        commentaryLabelTrailingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            nextCommentaryLabel.topAnchor.constraint(equalTo: topBorderLineView.bottomAnchor),
            nextCommentaryLabel.bottomAnchor.constraint(equalTo: bottomBorderLineView.topAnchor),
            nextCommentaryLabel.widthAnchor.constraint(equalTo: self.widthAnchor)])
        
        // to make nextCommentaryLabel being on the right of commentLabel
        nextCommentaryLabelLeadingConstraint = nextCommentaryLabel.leadingAnchor.constraint(equalTo: commentaryLabel.trailingAnchor)
        
        // to make nextCommentaryLabel occupy superview
        nextCommentaryLabelTrailingConstraint = nextCommentaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        nextCommentaryLabelLeadingConstraint.isActive = true
    }
}
