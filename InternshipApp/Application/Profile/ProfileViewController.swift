import UIKit

final class ProfileViewController: BaseViewController {

    var vm: ProfileViewModel?
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var backButton = UIImageView()
    private var screenTitle = UILabel()
    private var saveButton = CustomButton(text: TextValues.save, color: .appSecondary)
    
    private var addOptionsButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.addOptions, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    private var instructionLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vm?.getUser(vc: self)
    }
    
    private func configure() {
        vm?.getUser(vc: self)
        configureVC()
        setBackground()
        configureBackButton()
        configureScreenTitle()
        configureSaveButton()
        configureAvatarImageView()
        configureTextFields()
        configureInstructionLabel()
        configureAddOptionsButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func configureVC() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    
    func setBackground() {
        guard let vm else { return }
        
        if !vm.isMan {
            super.removeBackground()
            super.setGirlBackgroundImage()
        }
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
    
    private func configureScreenTitle() {
        screenTitle.text = TextValues.profile
        screenTitle.font = UIFont(name: TextValues.sairaMedium, size: Constants.profileTitleSize)
        screenTitle.textColor = .appWhite
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    @objc private func saveButtonAction() {
        vm?.saveButtonAction(saveButton: saveButton, nameTextField: nameTextField, vc: self, navigationController: navigationController)
        vm?.updateAvatar(saveButton: saveButton, vc: self, navigationController: navigationController)
    }
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(screenTitle)
        contentView.addSubview(saveButton)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameTextField)
        contentView.addSubview(instructionLabel)
//        contentView.addSubview(addOptionsButton)
        
        view.addSubview(backButton)
        view.addSubview(saveButton)
        view.addSubview(avatarImageView)
        view.addSubview(nameTextField)
        view.addSubview(addOptionsButton)
    }
    
    private func configureAvatarImageView() {
        avatarImageView.layer.cornerRadius = Constants.homeAvatarImageViewCornerRadius
        avatarImageView.image = vm?.avatarImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        avatarImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewAction))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func avatarImageViewAction() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func configureTextFields() {
        nameTextField.setTextFieldTitle(text: TextValues.name)
        nameTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        guard let vm else { return }
        
        guard nameTextField.getText() != vm.nameTextFieldText && !nameTextField.getText().isEmpty else {
            if nameTextField.getText().isEmpty && vm.isAvatarChanged {
                saveButton.set(.appYellow)
                return
            }
            saveButton.set(.appSecondary)
            vm.isTextChanged = false
            return
        }
        vm.isTextChanged = true
        saveButton.set(.appYellow)
    }
    
    private func configureInstructionLabel() {
        instructionLabel.text = TextValues.profileInstruction
        instructionLabel.textColor = .appSecondary
        instructionLabel.font = UIFont(name: TextValues.sairaRegular, size: Constants.profileInstructionLabelSize)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureAddOptionsButton() {
        addOptionsButton.addTarget(self, action: #selector(addOptionsButtonTarget), for: .touchUpInside)
    }
    
    
    @objc private func addOptionsButtonTarget() {
        vm?.addOptionsButtonAction(navigationController: navigationController)
    }
    
    
    func set(_ name: String) {
        nameTextField.setTextFieldText(text: name)
        vm?.nameTextFieldText = name
    }
    
    func set(_ image: UIImage) {
        avatarImageView.image = image
    }
    
    
    func setBorder() {
        avatarImageView.layer.borderWidth = Constants.homeAvatarImageViewBorderWidth
        avatarImageView.layer.borderColor = UIColor.appYellow.cgColor
    }
    
    
    private func setupLayoutConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            
            screenTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            screenTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: Constants.screenTitleLeadingPadding),
            screenTitle.widthAnchor.constraint(equalToConstant: Constants.screenTitleWidth),
            screenTitle.heightAnchor.constraint(equalToConstant: Constants.screenTitleHeight),
            
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            saveButton.leadingAnchor.constraint(equalTo: screenTitle.trailingAnchor, constant: Constants.saveButtonLeadingPadding),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.saveButtonTitleTrailingPadding),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonHeight),
            
            instructionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.instructionLabelTopAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: Constants.instructionLabelWidth),
            
            addOptionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addOptionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.addOptionsBottomAnchor),
        ])
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            vm?.avatarImage = selectedImage
            avatarImageView.image = vm?.avatarImage
            vm?.isAvatarChanged = true
            saveButton.set(.appYellow)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

