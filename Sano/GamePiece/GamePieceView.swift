//
//  GamePieceView.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GamePieceView: UIView {
    
    enum Style {
        case donutBlack
        case solidBlack
        case solidGray
    }
    
    var style: Style = .solidGray {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        switch style {
        case .solidGray:
            let grayColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
            drawSolidOval(in: rect, with: grayColor)
            
        case .solidBlack:
            drawSolidOval(in: rect, with: .black)
            
        case .donutBlack:
            drawDonutOval(in: rect, with: .black)
        }
    }
}

// MARK: - Private helpers

extension GamePieceView {
    
    private func drawSolidOval(in frame: CGRect, with color: UIColor) {
        let path = UIBezierPath(ovalIn: frame)
        color.setFill()
        path.fill()
    }
    
    private func drawDonutOval(in frame: CGRect, with color: UIColor) {
        drawSolidOval(in: frame, with: color)
        
        UIColor.white.setFill()
        let lineWidth: CGFloat = min(frame.size.width, frame.size.height) / 7
        let path = UIBezierPath(ovalIn: frame.insetBy(dx: lineWidth, dy: lineWidth))
        path.fill()
    }
}
