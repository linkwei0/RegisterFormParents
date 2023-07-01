//
//  FormParentView.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class ParentFormView: UIView {
    // MARK: - Properties
    
    private let nameView = ItemView()
    private let ageView = ItemView()
    
    var viewModel: ParentViewViewModel? {
        didSet {
            setupBindable()
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
    
    func setupBindable() {
        guard let viewModel = viewModel else { return }
        nameView.viewModel = viewModel.configureItemViewModel(.name)
        ageView.viewModel = viewModel.configureItemViewModel(.age)
        
        viewModel.onDidClearName = { [weak self] itemViewModel in
            self?.nameView.viewModel = itemViewModel
        }
        viewModel.onDidClearAge = { [weak self] itemViewModel in
            self?.ageView.viewModel = itemViewModel
        }
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNameView()
        setupAgeView()
    }
    
    private func setupNameView() {
        addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupAgeView() {
        addSubview(ageView)
        ageView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
