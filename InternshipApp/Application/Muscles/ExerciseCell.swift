//
//  ExerciseCell.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 07.08.2024.
//

import UIKit

class ExerciseCell: UITableViewCell {
    static let reuseID = TextValues.exerciseCellReuseID
    
    let exerciseImageView = UIImageView()
    let exerciseTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let moreAboutButton = UIButton()
    let arrowImageView = UIImageView()
    let checkmarkImageView = UIImageView()
    var isActive = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configureCell()
        configureExerciseImageView()
        configureExerciseTitleLabel()
        configureDescriptionLabel()
        configureMoreAboutButton()
        configureArrowImageView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func setupSubviews() {
        addSubview(exerciseImageView)
        addSubview(exerciseTitleLabel)
        addSubview(descriptionLabel)
        addSubview(moreAboutButton)
        addSubview(arrowImageView)
    }
    
    
    private func configureExerciseImageView() {
        exerciseImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureExerciseTitleLabel() {
        exerciseTitleLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.musclesTableViewExerciseCellTitleLabelSize)
        exerciseTitleLabel.textColor = .appWhite
        exerciseTitleLabel.textAlignment = .left
        exerciseTitleLabel.numberOfLines = 2
        exerciseTitleLabel.minimumScaleFactor = 0.5
        exerciseTitleLabel.adjustsFontSizeToFitWidth = true
        
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont(name: TextValues.nunitoLight, size: Constants.musclesTableViewExerciseCellDescriptionLabelSize)
        descriptionLabel.textColor = .appYellow
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 2
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureMoreAboutButton() {
        moreAboutButton.setTitle(TextValues.moreAbout, for: .normal)
        moreAboutButton.titleLabel?.font = UIFont(name: TextValues.nunitoLight, size: Constants.musclesTableViewExerciseCellMoreAboutLabelSize)
        moreAboutButton.setTitleColor(.appYellow, for: .normal)
        
        moreAboutButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureArrowImageView() {
        arrowImageView.image = UIImage.arrowRight
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureCell() {
        backgroundColor = .clear
        
        layer.cornerRadius = Constants.musclesTableViewExerciseCellCornerRadius
        layer.borderWidth = isActive ? Constants.musclesTableViewExerciseCellActiveBorderWidth : Constants.musclesTableViewExerciseCellInactiveBorderWidth
        layer.borderColor = isActive ? UIColor.appYellow.cgColor : UIColor.appSecondary.cgColor
    }
    
    
    func setImage(exerciseImageName: String) {
        exerciseImageView.image = UIImage(named: exerciseImageName)
    }
    
    
    func setTitle(_ text: String) {
        exerciseTitleLabel.text = text
    }
    
    
    func setDescription(exerciseType: String, equipment: String, level: String) {
        let text = "\(equipment), \(level), \(exerciseType)"
        descriptionLabel.text = text
    }
    
    
    func setCheckmark() {
        checkmarkImageView.image = UIImage.checkmarkBox
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if isActive {
            addSubview(checkmarkImageView)
            
            NSLayoutConstraint.activate([
                checkmarkImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.musclesTableViewExerciseCellCheckmarkImageViewTopAnchor),
                checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.musclesTableViewExerciseCellCheckmarkImageViewTrailingAnchor),
                checkmarkImageView.widthAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellCheckmarkImageViewWidth),
                checkmarkImageView.heightAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellCheckmarkImageViewHeight)
            ])
        } else {
            checkmarkImageView.removeFromSuperview()
        }
    }

    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            exerciseImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.musclesTableViewExerciseCellExerciseImageViewTopAnchor),
            exerciseImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.musclesTableViewExerciseCellExerciseImageViewLeadingAnchor),
            exerciseImageView.widthAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellExerciseImageViewWidth),
            exerciseImageView.heightAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellExerciseImageViewHeight),
            
            exerciseTitleLabel.topAnchor.constraint(equalTo: exerciseImageView.topAnchor),
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: Constants.musclesTableViewExerciseCellExerciseTitleLabelLeadingAnchor),
            exerciseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.musclesTableViewExerciseCellExerciseTitleLabelTrailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.musclesTableViewExerciseCellDescriptionLabelTopAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: exerciseTitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.musclesTableViewExerciseCellDescriptionLabelTrailingAnchor),
            
            moreAboutButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            moreAboutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.musclesTableViewExerciseCellMoreAboutButtonBottomAnchor),
            
            arrowImageView.centerYAnchor.constraint(equalTo: moreAboutButton.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: moreAboutButton.trailingAnchor, constant: Constants.musclesTableViewExerciseCellArrowImageViewLeadingAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellArrowImageViewWidth),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.musclesTableViewExerciseCellArrowImageViewHeight),
        ])
    }
}
