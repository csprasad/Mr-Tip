//
//  ThemeColor.swift
//  tip-calculator
//
//  Created by CS Prasad on 27/10/23.
//

import UIKit

struct ThemeColor {
    static var bg: UIColor {
        return UIColor(named: "background") ?? .systemBackground
    }
    
    static var views: UIColor {
        return UIColor(named: "views") ?? .secondarySystemBackground
    }
    
    static var primary: UIColor {
        return UIColor(named: "primary") ?? .systemBlue
    }
    
    static var secondary: UIColor {
        return UIColor(named: "secondary") ?? .systemOrange
    }
    
    static var text: UIColor {
        return UIColor(named: "text") ?? .label
    }
    
    static var separator: UIColor {
        return UIColor(named: "separator") ?? .separator
    }
    
    static var icon: UIColor {
        return UIColor(named: "icon") ?? .secondarySystemBackground
    }
}
