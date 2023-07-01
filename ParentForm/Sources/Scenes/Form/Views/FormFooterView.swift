//
//  FormFooterView.swift
//  ParentForm
//
//  Created by Артём Бацанов on 27.11.2022.
//

import UIKit

class FormFooterView: UITableViewHeaderFooterView {
    // MARK: - Properties
    
    private let deleteButton = UIButton(type: .system)
    private var viewModel: FormFooterViewModel?
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: FormFooterViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupCancelButton()
    }
    
    private func setupCancelButton() {
        contentView.addSubview(deleteButton)
        deleteButton.layer.borderWidth = 2.5
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.layer.cornerRadius = 24
        deleteButton.setTitle("Очистить", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.addTarget(self, action: #selector(didTapDeleteChildren), for: .touchUpInside)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapDeleteChildren() {
        viewModel?.didTapDeleteChildren()
    }
}
