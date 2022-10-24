//
//  FormViewController.swift
//  ParentForm
//

import UIKit

final class FormViewController: BaseViewController {
    // MARK: - Properties
    
    private let infoLabel = UILabel()
    private let parentView = FormParentView()
    private let childrenCountLabel = UILabel()
    private let addChildButton = UIButton(type: .system)
    private let tableView = UITableView()
    private let clearButton = UIButton(type: .system)
    
    private let viewModel: FormViewModel
    
    // MARK: - Init
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupInfoLabel()
        setupParentView()
        setupChildrenCountLabel()
        setupAddChildButton()
        setupTableView()
        setupClearButton()
    }
    
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.text = "Персональные данные"
        infoLabel.textColor = .black
        infoLabel.textAlignment = .left
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    private func setupParentView() {
        view.addSubview(parentView)
        parentView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
    }
    
    private func setupChildrenCountLabel() {
        view.addSubview(childrenCountLabel)
        childrenCountLabel.text = "Дети (макс. 5)"
        childrenCountLabel.textColor = .black
        childrenCountLabel.textAlignment = .left
        childrenCountLabel.numberOfLines = 0
        childrenCountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
        childrenCountLabel.snp.makeConstraints { make in
            make.top.equalTo(parentView.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    private func setupAddChildButton() {
        view.addSubview(addChildButton)
        addChildButton.setTitle("Добавить ребенка", for: .normal)
        addChildButton.setTitleColor(.systemBlue, for: .normal)
        addChildButton.layer.borderWidth = 2.5
        addChildButton.layer.cornerRadius = 24
        addChildButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addChildButton.layer.borderColor = UIColor.blue.cgColor
        addChildButton.addTarget(self, action: #selector(didTapAddChild), for: .touchUpInside)
        addChildButton.snp.makeConstraints { make in
            make.left.equalTo(childrenCountLabel.snp.right).offset(8)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(childrenCountLabel.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(180)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(FormCell.self, forCellReuseIdentifier: FormCell.reuseIdentifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(childrenCountLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupClearButton() {
        view.addSubview(clearButton)
        clearButton.layer.borderWidth = 2.5
        clearButton.layer.borderColor = UIColor.red.cgColor
        clearButton.layer.cornerRadius = 24
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.setTitleColor(.red, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.addTarget(self, action: #selector(didTapClearChildren), for: .touchUpInside)
        clearButton.titleLabel?.textAlignment = .center
        clearButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(64)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddChild() {
        viewModel.addChild()
    }
    
    @objc private func didTapClearChildren() {
        let actionSheet = UIAlertController(title: "Очистить?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .default, handler: { [weak self] _ in
            self?.parentView.nameCell.userDataTextField.text = nil
            self?.parentView.ageCell.userDataTextField.text = nil
            self?.viewModel.clearChildren()
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: Bind
    
    private func bindToViewModel() {
        viewModel.updateData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.updateAddButton = { [weak self] flag in
            self?.addChildButton.isHidden = flag
        }
    }
}

// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormCell.reuseIdentifier,
                                                       for: indexPath) as? FormCell else { return UITableViewCell() }
        cell.configure(with: viewModel.cellDefinition(indexPath: indexPath))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
