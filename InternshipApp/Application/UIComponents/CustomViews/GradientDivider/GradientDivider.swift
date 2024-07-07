//
//  GradientDivider.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class GradientDivider: UIView {
    var sideColor = UIColor.clear
    var centerColor = UIColor.black
    var stack = UIStackView()
    
    lazy var topGradientView: UIView = {
        let topGradientView = GradientView(width: Constants.gradientViewWidth, height: Constants.gradientViewHeight, topColor: sideColor, bottomColor: centerColor)
        return topGradientView
    }()
    
    lazy var bottomGradientView: UIView = {
        let bottomGradientView = GradientView(width: Constants.gradientViewWidth, height: Constants.gradientViewHeight, topColor: centerColor, bottomColor: sideColor)
        return bottomGradientView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(sideColor: UIColor, centerColor: UIColor) {
        super.init(frame: .zero)
        self.sideColor = sideColor
        self.centerColor = centerColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        let subview = self.loadViewFromXib()
        subview.frame = self.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(subview)
        
        setupSubviews()
        configureLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        addSubview(topGradientView)
        addSubview(bottomGradientView)
    }
    
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            topGradientView.widthAnchor.constraint(equalToConstant: Constants.gradientViewWidth),
            topGradientView.heightAnchor.constraint(equalToConstant: Constants.gradientViewHeight),
            
            bottomGradientView.widthAnchor.constraint(equalToConstant: Constants.gradientViewWidth),
            bottomGradientView.heightAnchor.constraint(equalToConstant: Constants.gradientViewHeight),
            bottomGradientView.topAnchor.constraint(equalTo: topGradientView.bottomAnchor)
        ])
    }

    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed(TextValues.gradientDividerText, owner: self)?.first as? UIView else { return UIView() }
        
        return view
    }
}
