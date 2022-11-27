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
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
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
        notificationCenter()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupInfoLabel()
        setupParentView()
        setupChildrenCountLabel()
        setupAddChildButton()
        setupTableView()
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
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(FormFooterView.self, forHeaderFooterViewReuseIdentifier: FormFooterView.reuseIdentifier)
        tableView.rowHeight = 200
        tableView.register(FormCell.self, forCellReuseIdentifier: FormCell.reuseIdentifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(childrenCountLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Notification Center
    
    private func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let newFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: newFrame.height, right: 0)
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
    
    @objc private func keyboardWillHide() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc private func didTapAddChild() {
        viewModel.addChild()
    }
    
    @objc private func didTapDeleteData() {
        let actionSheet = UIAlertController(title: "Очистить?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .default, handler: { [weak self] _ in
            self?.parentView.nameCell.userDataTextField.text = nil
            self?.parentView.ageCell.userDataTextField.text = nil
            self?.viewModel.clearChildren()
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Bind
    
    private func bindToViewModel() {
        viewModel.updateData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.deleteData = { [weak self] in
            self?.didTapDeleteData()
        }
        
        viewModel.updateAddButton = { [weak self] flag in
            self?.addChildButton.isHidden = flag
        }
    }
    
    // MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        let footerView = FormFooterView()
        footerView.configure(with: viewModel.footerViewModel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
