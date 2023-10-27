//
//  TipInputView.swift
//  tip-calculator
//
//  Created by CS Prasad on 27/10/23.
//

import UIKit

class TipInputView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .purple
    }
}
