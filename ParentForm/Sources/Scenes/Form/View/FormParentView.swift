//
//  FormParentView.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class FormParentView: UIView {
    // MARK: - Properties
    
    let nameCell = InfoCell(placeholderText: "Имя", placeholderTextField: "Имя")
    let ageCell = InfoCell(placeholderText: "Возраст", placeholderTextField: "Возраст")
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNameCell()
        setupAgeCell()
    }
    
    private func setupNameCell() {
        addSubview(nameCell)
        nameCell.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupAgeCell() {
        addSubview(ageCell)
        ageCell.snp.makeConstraints { make in
            make.top.equalTo(nameCell.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
