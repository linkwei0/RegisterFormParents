//
//  FormCell.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class FormCell: UITableViewCell {
    // MARK: - Properties
    
    private let nameCell = InfoCell(placeholderText: "Имя", placeholderTextField: "Имя")
    private let ageCell = InfoCell(placeholderText: "Возраст", placeholderTextField: "Возраст")
    private let deleteButton = UIButton(type: .system)
    
    private var viewModel: FormCellViewModel?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    func configure(with viewModel: FormCellViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Setup
        
    private func setup() {
        setupNameCell()
        setupAgeCell()
        setupDeleteButton()
    }
    
    private func setupNameCell() {
        contentView.addSubview(nameCell)
        nameCell.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(75)
            make.width.equalTo(180)
        }
    }
    
    private func setupAgeCell() {
        contentView.addSubview(ageCell)
        ageCell.snp.makeConstraints { make in
            make.top.equalTo(nameCell.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(75)
            make.width.equalTo(180)
        }
    }
    
    private func setupDeleteButton() {
        contentView.addSubview(deleteButton)
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.addTarget(self, action: #selector(didTapDeleteChild), for: .touchUpInside)
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameCell.snp.centerY)
            make.left.equalTo(nameCell.snp.right).offset(12)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - Actions

    @objc private func didTapDeleteChild() {
        viewModel?.didTapDeleteButton()
    }
}
