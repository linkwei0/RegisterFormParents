//
//  InfoCell.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class InfoCell: UIView {
    // MARK: - Properties
    
    private let infoPlaceholderLabel = UILabel()
    var userDataTextField = UITextField()
    
    // MARK: - Init
    
    init(placeholderText: String, placeholderTextField: String) {
        super.init(frame: .zero)
        infoPlaceholderLabel.text = placeholderText
        userDataTextField.placeholder = placeholderTextField
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 12
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupInfoPlaceHolderLabel()
        setupUserDataTextField()
    }
    
    private func setupInfoPlaceHolderLabel() {
        addSubview(infoPlaceholderLabel)
        infoPlaceholderLabel.textColor = .gray
        infoPlaceholderLabel.numberOfLines = 0
        infoPlaceholderLabel.textAlignment = .left
        infoPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    private func setupUserDataTextField() {
        addSubview(userDataTextField)
        userDataTextField.textColor = .black
        userDataTextField.snp.makeConstraints { make in
            make.top.equalTo(infoPlaceholderLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(16)
        }
    }
}
