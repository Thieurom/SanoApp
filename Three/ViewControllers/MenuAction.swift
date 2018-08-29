//
//  MenuAction.swift
//  Three
//
//  Created by Doan Le Thieu on 8/29/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

enum MenuItemStyle {
    case cancel
    case continnue
}

class MenuAction: NSObject {
    
    let title: String
    let style: MenuItemStyle
    let handler: (() -> Void)?
    
    init(title: String, style: MenuItemStyle, handler: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}
