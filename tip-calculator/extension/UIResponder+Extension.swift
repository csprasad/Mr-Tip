//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by CS Prasad on 29/10/23.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
