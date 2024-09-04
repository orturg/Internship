//
//  MusclesViewController.swift
//  InternshipApp
//
//  Created by Artur Nozhenko on 06.07.2024.
//

import UIKit

final class MusclesViewController: BaseViewController {
    var vm: MusclesViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let tableView = UITableView()
    private let resetButton = CustomButton(text: TextValues.reset, color: .appYellow)
    
    lazy var gradient: GradientView = {
        GradientView(width: Constants.gradientViewWidth, height: view.bounds.height, topColor: .clear, bottomColor: .black)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vcDidAppear()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm?.delegate = self
        vm?.getExercises { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.configure()
                self.tableView.reloadData()
                self.setResetButton()
            case .failure(let error):
                self.showAlert(vc: self, error: error)
            }
        }
    }
    
    
    private func vcDidAppear() {
        vm?.delegate = self
        vm?.getExercises { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.vm?.selectedCountForSection = Array(repeating: 0, count: self.vm?.exerciseList.count ?? 0)
                self.configure()
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(vc: self, error: error)
            }
        }
    }
    
    
    private func configure() {
        configureVC()
        configureTitleLabel()
        configureTableView()
        setupSubviews()
        setupLayoutConstraints()
    }
    
    
    private func configureVC() {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setupSubviews() {
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.text = TextValues.muscles
    }
    
    
    private func configureTableView() {
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseID)
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: ExerciseCell.reuseID)
        
        tableView.rowHeight = Constants.musclesTableViewCellHeight
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setResetButton() {
        guard let vm else { return }
        
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        
        if vm.isResetButtonActive {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: resetButton)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem()
        }
    }
    
    
    @objc private func resetButtonAction() {
        vm?.resetButtonAction()
    }
    
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.musclesTableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.musclesTableViewHorizontalAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.musclesTableViewHorizontalAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.musclesTableViewBottomAnchor)
        ])
    }
}


extension MusclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm else { return }
        
        if vm.selectedExercises.contains(indexPath) {
            vm.selectedExercises.remove(indexPath)
        } else {
            vm.selectedExercises.insert(indexPath)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let section = indexPath.section
        let selectedCells = vm.selectedExercises.filter { $0.section == section }.count
        vm.selectedCountForSection[section] = selectedCells
        
        vm.isResetButtonActive = vm.selectedExercises.count != 0
        setResetButton()
        
        updateHeaderCell(for: section)
    }
    
    
    private func updateHeaderCell(for section: Int) {
        guard let headerCell = tableView.headerView(forSection: section) as? SectionHeaderCell else {
            return
        }
        headerCell.backgroundColor = .clear
        headerCell.contentView.backgroundColor = .clear
        headerCell.setSelectedCells(amount: vm?.selectedCountForSection[section] ?? 0)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? Constants.musclesTableViewCellHeight : Constants.musclesTableViewSpacerHeight
    }
}

extension MusclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm else { return 0 }
        return vm.sectionExpanded[section] ? (vm.exerciseList[section].exercisesList.count * 2) - 1 : 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm else { return UITableViewCell() }
        
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.reuseID, for: indexPath) as? ExerciseCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            let adjustedRow = indexPath.row / 2
            let exercise = vm.exerciseList[indexPath.section].exercisesList[adjustedRow]
            
            cell.exercise = exercise
            cell.navigationController = navigationController
            cell.bringSubviewToFront(cell.moreAboutButton)
            
            cell.setImage(exerciseImageName: exercise.imageIcon)
            cell.setTitle(exercise.name)
            cell.setDescription(
                exerciseType: exercise.exerciseType,
                equipment: exercise.equipment,
                level: exercise.level
            )
            
            cell.isActive = vm.selectedExercises.contains(indexPath)
            cell.configureCell()
            cell.setCheckmark()
            
            return cell
        } else {
            let spacerCell = UITableViewCell()
            spacerCell.backgroundColor = .clear
            spacerCell.isUserInteractionEnabled = false
            return spacerCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let vm else { return UIView() }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderCell.reuseID) as? SectionHeaderCell else { return UITableViewCell() }
        
        header.contentView.backgroundColor = .clear
        header.backgroundView = UIView(frame: header.bounds)
        header.backgroundView?.backgroundColor = .clear
        
        header.setTitle(vm.exerciseList[section].muscleName)
        header.setImage(isArrowDown: vm.sectionExpanded[section])
        header.setSelectedCells(amount: vm.selectedCountForSection[section])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap(_:)))
        header.addGestureRecognizer(tapGesture)
        header.tag = section
        
        return header
    }
    
    
    @objc private func handleHeaderTap(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        vm?.sectionExpanded[section].toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm else { return 0 }
        return vm.exerciseList.count
    }
}


extension MusclesViewController: MusclesViewModelDelegate {
    func didResetExercises() {
        tableView.reloadData()
        setResetButton()
    }
}
