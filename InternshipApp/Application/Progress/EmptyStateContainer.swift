//
//  EmptyStateContainer.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 30.07.2024.
//

import UIKit

class EmptyStateContainer: UIView {
    
    var text: String
    var image: UIImage
    
    var label = UILabel()
    var imageView = UIImageView()
    
    init(text: String, image: UIImage) {
        self.text = text
        self.image = image
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureContainerView()
        configureLabel()
        configureImageView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(imageView)
    }
    
    private func configureContainerView() {
        layer.cornerRadius = Constants.progressVCEmptyStateContainerCornerRadius
        layer.borderWidth = Constants.progressVCEmptyStateContainerBorderWidth
        layer.borderColor = UIColor.appWhite.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabel() {
        label.textColor = .appWhite
        label.font = UIFont(name: TextValues.helveticaNeue, size: Constants.progressVCEmptyStateContainerLabelSize)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        setAttributedText(text: text, lineSpacing: 5)
    }
    
    private func setAttributedText(text: String, lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.appWhite,
                .font: UIFont(name: TextValues.helveticaNeue, size: Constants.progressVCEmptyStateContainerLabelSize)
            ]
        )
        
        label.attributedText = attributedString
    }
    
    private func configureImageView() {
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.progressVCEmptyStateContainerImageViewLeadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.progressVCEmptyStateContainerImageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constants.progressVCEmptyStateContainerImageViewHeight),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.progressVCEmptyStateContainerLabelLeadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.progressVCEmptyStateContainerLabelTrailingAnchor),
        ])
    }
}
