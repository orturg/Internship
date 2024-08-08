//
//  Constants.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 04.07.2024.
//

import Foundation

enum Constants {
    static let customRoundedRectangleButtonHeight: CGFloat = 49
    static let customRoundedRectangleButtonWidth: CGFloat = 289
    static let buttonLabelSize: CGFloat = 16
    static let textFieldPaddingWidth: CGFloat = 10
    static let textFieldCornerRadius: CGFloat = 12
    static let textFieldBorderWidth: CGFloat = 1
    static let customRoundedRectangleButtonCornerRadius: CGFloat = 24
    static let customRadioButtonWidth: CGFloat = 15
    static let customRadioButtonHeight: CGFloat = 15
    static let customRadioButtonCornerRadius: CGFloat = 8
    static let customRadioButtonBorderWidth: CGFloat = 2
    static let customRadioButtonInnerCircleWidth: CGFloat = 6
    static let customRadioButtonInnerCircleHeight: CGFloat = 6
    static let customRadioButtonInnerCircleCornerRadius: CGFloat = 3
    static let customRadioButtonInnerCircleBorderWidth: CGFloat = 5
    static let customCheckboxSwitchWidth: CGFloat = 16
    static let customCheckboxSwitchHeight: CGFloat = 16
    static let customCheckboxSwitchCornerRadius: CGFloat = 3
    static let customCheckboxSwitchBorderWidth: CGFloat = 3
    static let customCheckboxSwitchcheckmarkImageViewWidth: CGFloat = 8
    static let customCheckboxSwitchcheckmarkImageViewHeight: CGFloat = 5
    static let gradientViewWidth: CGFloat = 393
    static let gradientViewHeight: CGFloat = 91
    static let gradientViewSpacing: CGFloat = 45.5
    static let startViewControllerButtonPadding: CGFloat = 181
    static let homeTitleLabelPadding: CGFloat = 76
    static let startScreenButtonWidth: CGFloat = 144
    static let startScreenButtonHeight: CGFloat = 44
    static let homeVCTitleLabelSize: CGFloat = 24
    static let fullNamePattern = #"^[a-zA-Z0-9-''']+(?: [a-zA-Z0-9-''']+)*$"#
    static let emailPattern = #"^\S+@\S+\.\S+$"#
    static let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let signUpButtonTopAnchor: CGFloat = 80
    static let loginButtonLeadingAnchor: CGFloat = 8
    static let forgotPasswordTopAnchorPadding: CGFloat = 16
    static let loginButtonTopAnchor: CGFloat = 61
    static let loginButtonBottomAnchor: CGFloat = 20
    static let forgotPasswordInstructionLabelSize: CGFloat = 16
    static let instructionLabelTopAnchor: CGFloat = 48
    static let instructionLabelWidth: CGFloat = 289
    static let instructionLabelHeight: CGFloat = 75
    static let continueButtonTopAnchor: CGFloat = 80
    static let backButtonBottomAnchor: CGFloat = 28
    static let customAlertRoundedRectangleButtonWidth: CGFloat = 120
    static let customAlertCornerRadius: CGFloat = 12
    static let customAlertBorderWidth: CGFloat = 2
    static let alertContainerMessageLabelSize: CGFloat = 16
    static let alertContainerMessageLabelPadding: CGFloat = 16
    static let alertContainerViewWidth: CGFloat = 283
    static let alertContainerViewHeight: CGFloat = 153
    static let alertContainerCancelButtonLeadingAnchor: CGFloat = 50
    static let alertContainerOkButtonLeadingAnchor: CGFloat = 50
    static let homeAvatarImageViewCornerRadius: CGFloat = 8
    static let homeAvatarImageViewBorderWidth: CGFloat = 1
    static let profileInstructionLabelSize: CGFloat = 16
    static let addOptionsBottomAnchor: CGFloat = 48
    static let emptyAlertHeight: CGFloat = 75
    static let emptyAlertSuccessImageViewWidth: CGFloat = 21
    static let emptyAlertSuccessImageViewHeight: CGFloat = 21
    static let emptyAlertMessageLeadingPadding: CGFloat = 15
    static let profileTitleSize: CGFloat = 18
    static let backButtonLeadingPadding: CGFloat = 16
    static let backButtonWidth: CGFloat = 62
    static let backButtonHeight: CGFloat = 28
    static let screenTitleLeadingPadding: CGFloat = 82
    static let screenTitleWidth: CGFloat = 56
    static let screenTitleHeight: CGFloat = 28
    static let saveButtonLeadingPadding: CGFloat = 93
    static let saveButtonTitleTrailingPadding: CGFloat = 16
    static let saveButtonHeight: CGFloat = 28
    static let selectOptionsContainerWidth: CGFloat = 328
    static let selectOptionsContainerHeight: CGFloat = 656
    static let selectOptionsContainerTitleSize: CGFloat = 18
    static let selectOptionsContainerTopAnchor: CGFloat = 19
    static let selectOptionsContainerTitleWidth: CGFloat = 112
    static let selectOptionsContainerTitleHeight: CGFloat = 28
    static let selectOptionsContainerButtonWidth: CGFloat = 120
    static let selectOptionsContainerButtonHeight: CGFloat = 40
    static let selectOptionsContainerCancelButtonLeadingAnchor: CGFloat = 11
    static let selectOptionsContainerButtonBottomAnchor: CGFloat = 8
    static let selectOptionsContainerSelectButtonTrailingAnchor: CGFloat = 18
    static let textFieldCellHeight: CGFloat = 90
    static let profileVCTableViewBottomAnchor: CGFloat = 20
    static let unitsLabelSize: CGFloat = 18
    static let textFieldCellTextFieldWidth: CGFloat = 114
    static let unitsLabelLeadingAnchor: CGFloat = 10
    static let unitsLabelWidth: CGFloat = 26
    static let unitsLabelHeight: CGFloat = 22
    static let textFieldCellCustomSwitchTrailingAnchor: CGFloat = 5
    static let selectOptionsTableViewPadding: CGFloat = 10
    static let selectOptionsCellHeight: CGFloat = 40
    static let optionCellOptionLabelSize: CGFloat = 18
    static let optionCellButtonLeadingAnchor: CGFloat = 20
    static let optionCellButtonWidth: CGFloat = 16
    static let optionCellButtonHeight: CGFloat = 16
    static let optionCellOptionLabelLeadingAnchor: CGFloat = 18
    static let programmaticCustomTextFieldTitleLabelSize: CGFloat = 18
    static let programmaticCustomTextFieldHeight: CGFloat = 70
    static let programmaticCustomTextFieldTitleLabelHeight: CGFloat = 7
    static let programmaticCustomTextFieldTitleTextFieldHeight: CGFloat = 42
    static let homeCollectionViewTopAnchor: CGFloat = 37
    static let homeCollectionViewHorizontalAnchor: CGFloat = 40
    static let homeCollectionViewBottomAnchor: CGFloat = 24
    static let homeCollectionViewCellWidth: CGFloat = 270
    static let homeCollectionViewCellHeight: CGFloat = 104
    static let homeCollectionViewCellCornerRadius: CGFloat = 10
    static let homeCollectionViewCellBorderWidth: CGFloat = 2
    static let homeCollectionViewCellTitleSize: CGFloat = 20
    static let homeCollectionViewCellQuantitySize: CGFloat = 30
    static let homeCollectionViewCellMetricSize: CGFloat = 20
    static let homeCollectionViewCellCircleCornerRadius: CGFloat = 23
    static let homeCollectionViewCellDifferenceLabelSize: CGFloat = 19
    static let homeCollectionViewCellTitleLabelTopAnchor: CGFloat = 16
    static let homeCollectionViewCellTitleLabelLeadingAnchor: CGFloat = 32
    static let homeCollectionViewCellQuantityLabelTopAnchor: CGFloat = 10
    static let homeCollectionViewCellQuantityLabelLeadingAnchor: CGFloat = 36
    static let homeCollectionViewCellMetricLabelLeadingAnchor: CGFloat = 10
    static let homeCollectionViewCellMetricLabelBottomAnchor: CGFloat = 5
    static let homeCollectionViewCellCircleTrailingAnchor: CGFloat = 21
    static let homeCollectionViewCellCircleBottomAnchor: CGFloat = 13
    static let homeCollectionViewCellCircleWidthAnchor: CGFloat = 45
    static let homeCollectionViewCellCircleHeightAnchor: CGFloat = 45
    static let progressChartScreenTitleLabelSize: CGFloat = 18
    static let progressChartScreenCenterLabelSize: CGFloat = 24
    static let progressChartScreenDateLabelSize: CGFloat = 16
    static let progressChartScreenCenterLabelTopAnchor: CGFloat = 132
    static let progressChartScreenDateLabelTopAnchor: CGFloat = 24
    static let progressChartScreenDateLabelHorizontalAnchor: CGFloat = 36
    static let progressChartScreenScrollViewTopAnchor: CGFloat = 24
    static let progressChartScreenScrollViewHorizontalAnchor: CGFloat = 16
    static let progressChartScreenScrollViewBottomAnchor: CGFloat = 125
    static let chartBarWidth: CGFloat = 58
    static let chartBarSpacing: CGFloat = 12
    static let chartViewDateLabelHeight: CGFloat = 20
    static let chartViewBottomPadding: CGFloat = 5
    static let chartViewStartingX: CGFloat = 35
    static let chartViewBarCornerRadius: CGFloat = 16
    static let chartViewValueLabelSize: CGFloat = 14
    static let chartViewValueLabelHeight: CGFloat = 20
    static let chartViewDateLabelSize: CGFloat = 14
    static let chartViewDifferenceViewWidth: CGFloat = 56
    static let chartViewDifferenceViewHeight: CGFloat = 25
    static let chartViewDifferenceViewCornerRadius: CGFloat = 13
    static let chartViewDifferenceLabelSize: CGFloat = 14
    static let progressVCEmptyStateViewHorizontalAnchor: CGFloat = 44
    static let progressVCEmptyStateViewHeight: CGFloat = 110
    static let progressVCTableViewTopAnchor: CGFloat = 95
    static let progressVCTableHorizontalAnchor: CGFloat = 43
    static let progressVCTableBottomAnchor: CGFloat = 24
    static let progressVCEmptyStateContainerCornerRadius: CGFloat = 8
    static let progressVCEmptyStateContainerBorderWidth: CGFloat = 2
    static let progressVCEmptyStateContainerLabelSize: CGFloat = 16
    static let progressVCEmptyStateContainerLabelLeadingAnchor: CGFloat = 14
    static let progressVCEmptyStateContainerLabelTrailingAnchor: CGFloat = 50
    static let progressVCEmptyStateContainerImageViewLeadingAnchor: CGFloat = 21
    static let progressVCEmptyStateContainerImageViewWidth: CGFloat = 21
    static let progressVCEmptyStateContainerImageViewHeight: CGFloat = 21
    static let progressTableViewCellTitleLabelSize: CGFloat = 18
    static let progressTableViewCellTitleLabelLeadingAnchor: CGFloat = 8
    static let progressTableViewCellLineTopAnchor: CGFloat = 12
    static let progressTableViewCellLineHeight: CGFloat = 2
    static let progressTableViewCellLineBottomAnchor: CGFloat = 32
    static let deleteAccountInstructionLabelSize: CGFloat = 16
    static let deleteAccountVCDeleteButtonBottomAnchor: CGFloat = 48
    static let deleteAlertContainerHeight: CGFloat = 153
    static let musclesTableViewCellHeight: CGFloat = 171
    static let musclesResetButtonTrailingAnchor: CGFloat = 16
    static let musclesTableViewTopAnchor: CGFloat = 66
    static let musclesTableViewHorizontalAnchor: CGFloat = 43
    static let musclesTableViewBottomAnchor: CGFloat = 24
    static let musclesTableViewSpacerHeight: CGFloat = 12
    static let musclesTableViewSectionHeaderCellAmountLabelSize: CGFloat = 18
    static let musclesTableViewSectionHeaderCellAmountLabelTrailingAnchor: CGFloat = 2
    static let musclesTableViewSectionHeaderCellArrowCenterConstant: CGFloat = 2
    static let musclesTableViewSectionHeaderCellArrowWidth: CGFloat = 19
    static let musclesTableViewSectionHeaderCellArrowHeight: CGFloat = 8
    static let musclesTableViewSectionHeaderCellTitleLeadingAnchor: CGFloat = 16
    static let musclesTableViewSectionHeaderCellLineTopAnchor: CGFloat = 12
    static let musclesTableViewSectionHeaderCellLineHeight: CGFloat = 2
    static let musclesTableViewSectionHeaderCellLineBottomAnchor: CGFloat = 12
    static let musclesTableViewExerciseCellTitleLabelSize: CGFloat = 18
    static let musclesTableViewExerciseCellDescriptionLabelSize: CGFloat = 14
    static let musclesTableViewExerciseCellMoreAboutLabelSize: CGFloat = 16
    static let musclesTableViewExerciseCellCornerRadius: CGFloat = 8
    static let musclesTableViewExerciseCellActiveBorderWidth: CGFloat = 2
    static let musclesTableViewExerciseCellInactiveBorderWidth: CGFloat = 1
    static let musclesTableViewExerciseCellCheckmarkImageViewTopAnchor: CGFloat = 4
    static let musclesTableViewExerciseCellCheckmarkImageViewTrailingAnchor: CGFloat = 4
    static let musclesTableViewExerciseCellCheckmarkImageViewWidth: CGFloat = 22
    static let musclesTableViewExerciseCellCheckmarkImageViewHeight: CGFloat = 22
    static let musclesTableViewExerciseCellExerciseImageViewTopAnchor: CGFloat = 24
    static let musclesTableViewExerciseCellExerciseImageViewLeadingAnchor: CGFloat = 21
    static let musclesTableViewExerciseCellExerciseImageViewWidth: CGFloat = 45
    static let musclesTableViewExerciseCellExerciseImageViewHeight: CGFloat = 45
    static let musclesTableViewExerciseCellExerciseTitleLabelLeadingAnchor: CGFloat = 24
    static let musclesTableViewExerciseCellExerciseTitleLabelTrailingAnchor: CGFloat = 20
    static let musclesTableViewExerciseCellDescriptionLabelTopAnchor: CGFloat = 89
    static let musclesTableViewExerciseCellDescriptionLabelTrailingAnchor: CGFloat = 20
    static let musclesTableViewExerciseCellMoreAboutButtonBottomAnchor: CGFloat = 16
    static let musclesTableViewExerciseCellArrowImageViewLeadingAnchor: CGFloat = 6
    static let musclesTableViewExerciseCellArrowImageViewWidth: CGFloat = 18
    static let musclesTableViewExerciseCellArrowImageViewHeight: CGFloat = 18
}
