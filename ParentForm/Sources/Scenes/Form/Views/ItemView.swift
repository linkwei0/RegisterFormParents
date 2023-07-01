//
//  InfoCell.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class ItemView: UIView {
    // MARK: - Properties
    
    private let infoLabel = UILabel()
    private let dataTextField = UITextField()
    
    var viewModel: ItemViewViewModel? {
        didSet {
            setupBindables()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Bindables
    
    func setupBindables() {
        guard let viewModel = viewModel else { return }
        infoLabel.text = viewModel.staticInfoText
        dataTextField.placeholder = viewModel.staticPlaceholderText
        dataTextField.text = viewModel.dynamicText
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupBackground()
        setupInfoPlaceHolderLabel()
        setupUserDataTextField()
    }
    
    private func setupBackground() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 12
    }
    
    private func setupInfoPlaceHolderLabel() {
        addSubview(infoLabel)
        infoLabel.textColor = .gray
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    private func setupUserDataTextField() {
        addSubview(dataTextField)
        dataTextField.delegate = self
        dataTextField.textColor = .black
        dataTextField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}

// MARK: - UITextFieldDelegate

extension ItemView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let viewModel = viewModel else { return }
        viewModel.nameDidChange(text: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
