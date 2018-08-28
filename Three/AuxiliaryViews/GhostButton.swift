//
//  GhostButton.swift
//  Three
//
//  Created by Doan Le Thieu on 8/28/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class GhostButton: UIButton {
    
    convenience init(title: String, icon: UIImage? = nil) {
        self.init(frame: CGRect.zero)
        
        setImage(icon, for: .normal)
        setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        contentHorizontalAlignment = .leading
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
}
