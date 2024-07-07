//
//  GradientView.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class GradientView: UIView {
    var width: CGFloat = Constants.gradientViewWidth
    var height: CGFloat = Constants.gradientViewHeight
    var topColor = UIColor()
    var bottomColor = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(width: CGFloat, height: CGFloat, topColor: UIColor, bottomColor: UIColor) {
        super.init(frame: .zero)
        self.width = width
        self.height = height
        self.topColor = topColor
        self.bottomColor = bottomColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func configure() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(gradientLayer)
    }
}

