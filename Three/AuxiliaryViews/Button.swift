//
//  Button.swift
//  Three
//
//  Created by Doan Le Thieu on 8/31/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    enum Style {
        case primary
        case secondary
    }
    
    let style: Style
    
    // MARK: Initializations
    init(style: Style) {
        self.style = style
        super.init(frame: CGRect.zero)
        
        config()
    }
    
    convenience init() {
        self.init(style: .primary)
    }
    
    override convenience init(frame: CGRect) {
        self.init(style: .primary)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(style: .primary)
    }
    
    private func config() {
        switch style {
        case .primary:
            backgroundColor = .black
            setTitleColor(.white, for: .normal)

        case .secondary:
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 3
        }
        
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
}
