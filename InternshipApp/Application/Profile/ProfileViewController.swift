
import UIKit

final class ProfileViewController: BaseViewController {
    
    var vm: ProfileViewModel?
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var backButton = UIImageView()
    private var screenTitle = UILabel()
    private var saveButton = CustomButton(text: TextValues.save, color: .appSecondary)
    
    private lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
    }()
    
    private var addOptionsButton = CustomRoundedRectangleButton(buttonBackgroundColor: .appYellow, buttonText: TextValues.addOptions, textColor: .black, height: Constants.customRoundedRectangleButtonHeight, width: Constants.customRoundedRectangleButtonWidth)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    private var instructionLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    var cells: [OptionCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.getData(vc: self) { [weak self] in
            guard let self else { return }
            self.configure()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm?.getUser(vc: self)
        
        configure()
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
        configureTableView()
        configureAddOptionsButton()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    private func configureVC() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        vm?.delegate = self
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
        guard let vm else { return }
        
        vm.saveButtonAction(saveButton: saveButton, nameTextField: nameTextField, vc: self, navigationController: navigationController)
        vm.updateAvatar(saveButton: saveButton, vc: self, navigationController: navigationController)
        updateCells()
        vm.updateOptionTextFields(saveButton: saveButton, textFields: vm.textFieldCells, vc: self, navigationController: navigationController)
        
    }
    
    
    private func updateCells() {
        vm?.textFieldCells = []
        
        for i in 0..<cells.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? TextFieldCell {
                let textFieldCell = TextFieldCell()
                textFieldCell.setTextFieldTitle(text: cell.textField.titleLabel.text ?? "")
                textFieldCell.setTextFieldText(text: cell.textField.getText())
                textFieldCell.setUnitsText(text: cell.textField.titleLabel.text == TextValues.weight ? TextValues.kg : TextValues.cm)
                textFieldCell.customSwitch.isOn = cell.customSwitch.isOn
                vm?.textFieldCells.append(textFieldCell)
                
                if (textFieldCell.textField.titleLabel.text == TextValues.weight || textFieldCell.textField.titleLabel.text == TextValues.height) && Int(textFieldCell.textField.getText()) ?? 0 > 300 {
                    saveButton.set(.appSecondary)
                    vm?.isTableViewActive = false
                } else if Int(textFieldCell.textField.getText()) ?? 0 > 100 {
                    saveButton.set(.appSecondary)
                    vm?.isTableViewActive = false
                }
                
                if Int(textFieldCell.textField.titleLabel.text!) == 0 || textFieldCell.textField.titleLabel.text == nil {
                    saveButton.set(.appSecondary)
                    vm?.isTableViewActive = false
                }
                
            }
        }
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
    
    
    private func configureTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = Constants.textFieldCellHeight
        tableView.backgroundColor = .black
        
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        vm?.tableView = tableView
    }
    
    
    private func configureAddOptionsButton() {
        addOptionsButton.addTarget(self, action: #selector(addOptionsButtonTarget), for: .touchUpInside)
    }
    
    
    @objc private func addOptionsButtonTarget() {
        vm?.delegate = self
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
            
            
            addOptionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addOptionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.addOptionsBottomAnchor),
        ])
        
        layoutTableView()
    }
    
    
    func layoutTableView() {
        guard let vm else { return }
        
        if !cells.isEmpty || !vm.textFieldCells.isEmpty {
            instructionLabel.removeFromSuperview()
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.instructionLabelTopAnchor),
                tableView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: addOptionsButton.topAnchor, constant: -Constants.profileVCTableViewBottomAnchor),
            ])
        } else {
            tableView.removeFromSuperview()
            contentView.addSubview(instructionLabel)
            
            NSLayoutConstraint.activate([
                instructionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constants.instructionLabelTopAnchor),
                instructionLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
                instructionLabel.widthAnchor.constraint(equalToConstant: Constants.instructionLabelWidth),
            ])
        }
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


extension ProfileViewController: ProfileVCDelegate {
    func add(_ cell: OptionCell) {
        cells.append(cell)
        tableView.reloadData()
    }
    
    func remove(_ cell: OptionCell) {
        cells.removeAll { $0.optionLabel.text == cell.optionLabel.text }
        vm?.textFieldCells.removeAll { $0.textField.titleLabel.text == cell.optionLabel.text }
        tableView.reloadData()
    }
    
}


extension ProfileViewController: UITableViewDelegate {
    
}


extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.reuseID, for: indexPath) as? TextFieldCell else { return UITableViewCell() }
        
        let optionTitle = cells[indexPath.row].optionLabel.text
        guard let optionTitle else { return UITableViewCell() }
        cell.setTextFieldTitle(text: optionTitle)
        cell.setUnitsText(text: optionTitle == TextValues.weight ? TextValues.kg : TextValues.cm)
        
        cell.delegate = self
        
        
        if !vm.textFieldCells.contains(where: { $0.textField.titleLabel.text == cell.textField.titleLabel.text }) {
            vm.textFieldCells.append(cell)
        }
        
        cell.setTextFieldText(text: vm.textFieldCells[indexPath.row].textField.getText())
        cell.setSwitch(isOn: vm.textFieldCells[indexPath.row].customSwitch.isOn)
        
        return cell
    }
}

extension ProfileViewController: TextFieldCellDelegate {
    func textFieldCell(_ cell: TextFieldCell, didChangeText text: String) {
        
        var isTextChanged = false
        for i in 0..<cells.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? TextFieldCell {
                if cell.textField.textField.text != text {
                    isTextChanged = true
                    break
                }
            }
        }
        
        if isTextChanged || !nameTextField.getText().isEmpty  {
            saveButton.set(.appYellow)
            vm?.isTableViewActive = true
        } else {
            saveButton.set(.appSecondary)
            vm?.isTableViewActive = false
        }
    }
    
    
    func textFieldCell(_ cell: TextFieldCell, didChangeSwitchValue isOn: Bool) {
        saveButton.set(.appYellow)
        vm?.isTableViewActive = true
    }
}
