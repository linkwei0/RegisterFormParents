//
//  FormFooterViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 27.11.2022.
//

import Foundation

protocol FormFooterViewModelDelegate: AnyObject {
    func viewModelDidRequestToDeleteData(_ viewModel: FormFooterViewModel)
}

class FormFooterViewModel {
    weak var delegate: FormFooterViewModelDelegate?
    
    func didTapDeleteChildren() {
        delegate?.viewModelDidRequestToDeleteData(self)
    }
}
