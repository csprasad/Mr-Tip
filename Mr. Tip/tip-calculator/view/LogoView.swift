//
//  LogoView.swift
//  tip-calculator
//
//  Created by CS Prasad on 27/10/23.
//

import UIKit

class LogoView: UIView {
    
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(named: "calculator"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let mustachImageView: UIImageView = {
        let view = UIImageView(image: .init(named: "mustache"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLable: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr. TIP",
            attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(4, 3))
        label.textColor = ThemeColor.text
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "Calculator",
                           font: ThemeFont.demibold(ofSize: 20),
                           textAlignment: .left)
    }()
    
    private lazy var zStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        topLable,
        mustachImageView
        ])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
        zStackview,
        bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -4
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
        imageView,
        vStackView
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
        
        mustachImageView.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
}
