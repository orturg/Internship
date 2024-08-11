//
//  ExerciseDetailViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 09.08.2024.
//

import UIKit
import ReadMoreTextView

final class ExerciseDetailViewController: UIViewController {
    
    var vm: ExerciseDetailViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let backButton = UIImageView()
    private let exerciseInstructionImageView = UIImageView()
    private let exerciseImageView = UIImageView()
    private let exerciseTitleLabel = UILabel()
    private let exerciseDescriptionLabel = UILabel()
    private let exerciseInstructionLabel = ReadMoreTextView()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        configureVC()
        configureScrollView()
        configureBackButton()
        configureExerciseInstructionImageView()
        configureExerciseImageView()
        configureExerciseTitleLabel()
        configureDescriptionLabel()
        configureExerciseInstructionLabel()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
    }
    
    
    private func configureScrollView() {
        scrollView.addSubview(contentView)
        
        contentView.addSubview(exerciseInstructionImageView)
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exerciseTitleLabel)
        contentView.addSubview(exerciseDescriptionLabel)
        contentView.addSubview(exerciseInstructionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureBackButton() {
        backButton.image = UIImage.back
        backButton.isUserInteractionEnabled = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        backButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func configureExerciseInstructionImageView() {
        exerciseInstructionImageView.image = UIImage(named: vm?.exercise?.exerciseImage ?? "")
        exerciseInstructionImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureExerciseImageView() {
        exerciseImageView.image = UIImage(named: vm?.exercise?.imageIcon ?? "")
        exerciseImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureExerciseTitleLabel() {
        exerciseTitleLabel.text = vm?.exercise?.name ?? ""
        exerciseTitleLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.exerciseDetailExerciseTitleLabelSize)
        exerciseTitleLabel.textColor = .appWhite
        exerciseTitleLabel.textAlignment = .left
        exerciseTitleLabel.numberOfLines = 2
        exerciseTitleLabel.minimumScaleFactor = 0.5
        exerciseTitleLabel.adjustsFontSizeToFitWidth = true
        
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureDescriptionLabel() {
        let text = "\(vm?.exercise?.equipment ?? ""), \(vm?.exercise?.level ?? ""), \(vm?.exercise?.exerciseType ?? "")"
        exerciseDescriptionLabel.text = text
        
        exerciseDescriptionLabel.font = UIFont(name: TextValues.nunitoLight, size: Constants.exerciseDetailDescriptionTitleLabelSize)
        exerciseDescriptionLabel.textColor = .appYellow
        exerciseDescriptionLabel.textAlignment = .left
        exerciseDescriptionLabel.numberOfLines = 2
        exerciseDescriptionLabel.minimumScaleFactor = 0.5
        exerciseDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        exerciseDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureExerciseInstructionLabel() {
        exerciseInstructionLabel.maximumNumberOfLines = 4
        exerciseInstructionLabel.backgroundColor = .clear
        
        exerciseInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appSecondary,
            NSAttributedString.Key.font: UIFont(name: TextValues.sairaThin, size: Constants.exerciseDetailDescriptionInstructionLabelSize)
        ]
        
        let showMoreTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appYellow,
            NSAttributedString.Key.font: UIFont(name: TextValues.sairaThin, size: Constants.exerciseDetailDescriptionInstructionLabelSize)
        ]
        exerciseInstructionLabel.shouldTrim = true
        exerciseInstructionLabel.attributedText = NSAttributedString(string: vm?.exercise?.descriptions ?? "", attributes: textAttributes as [NSAttributedString.Key : Any])
        exerciseInstructionLabel.attributedReadMoreText = NSAttributedString(string: TextValues.showMore, attributes: showMoreTextAttributes as [NSAttributedString.Key : Any])
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingPadding),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonHeight),
            
            exerciseInstructionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            exerciseInstructionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            exerciseInstructionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            exerciseInstructionImageView.heightAnchor.constraint(equalToConstant: Constants.exerciseDetailExerciseInstructionImageViewHeight),
            
            exerciseImageView.topAnchor.constraint(equalTo: exerciseInstructionImageView.bottomAnchor, constant: Constants.exerciseDetailExerciseImageViewBottomAnchor),
            exerciseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.exerciseDetailExerciseImageViewLeadingAnchor),
            exerciseImageView.widthAnchor.constraint(equalToConstant: Constants.exerciseDetailExerciseImageViewWidth),
            exerciseImageView.heightAnchor.constraint(equalToConstant: Constants.exerciseDetailExerciseImageViewHeight),
            
            exerciseTitleLabel.topAnchor.constraint(equalTo: exerciseImageView.topAnchor),
            exerciseTitleLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: Constants.exerciseDetailExerciseTitleLabelLeadingAnchor),
            
            exerciseDescriptionLabel.topAnchor.constraint(equalTo: exerciseTitleLabel.bottomAnchor, constant: Constants.exerciseDetailExerciseDescriptionLabelTopAnchor),
            exerciseDescriptionLabel.leadingAnchor.constraint(equalTo: exerciseTitleLabel.leadingAnchor),
            
            exerciseInstructionLabel.topAnchor.constraint(equalTo: exerciseDescriptionLabel.bottomAnchor, constant: Constants.exerciseDetailExerciseInstructionLabelTopAnchor),
            exerciseInstructionLabel.leadingAnchor.constraint(equalTo: exerciseImageView.leadingAnchor),
            exerciseInstructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.exerciseDetailExerciseInstructionLabelTrailingAnchor),
            exerciseInstructionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.exerciseDetailExerciseInstructionLabelBottomAnchor)
        ])
    }
}
