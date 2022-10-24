//
//  FormCellViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import Foundation

protocol FormCellViewModelDelegate: AnyObject {
    func formCellViewModelDidRequestToDeleteChild(_ viewModel: FormCellViewModel)
}

class FormCellViewModel {
    // MARK: - Properties
    
    weak var delegate: FormCellViewModelDelegate?
    
    private(set) var child: Child
    
    // MARK: - Init
    
    init(child: Child) {
        self.child = child
    }
    
    // MARK: - Public methods
    
    func didTapDeleteButton() {
        delegate?.formCellViewModelDidRequestToDeleteChild(self)
    }
}
