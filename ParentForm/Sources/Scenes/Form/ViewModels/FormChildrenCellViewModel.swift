//
//  FormCellViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import Foundation

enum ItemType {
    case name, age
    
    var infoText: String {
        switch self {
        case .name:
            return "Имя"
        case .age:
            return "Возраст"
        }
    }
    
    var placeholder: String {
        switch self {
        case .name:
            return "Имя"
        case .age:
            return "Возраст"
        }
    }
}

protocol FormChildrenCellViewModelDelegate: AnyObject {
    func childrenCellViewModelDidRequestToDeleteChild(_ viewModel: FormChildrenCellViewModel)
    func childrenCellViewModelDidRequestToChangeData(_ viewModel: FormChildrenCellViewModel, type: ItemType, child: Child)
}

class FormChildrenCellViewModel {
    // MARK: - Properties
    
    weak var delegate: FormChildrenCellViewModelDelegate?
    
    var itemViewModel: ItemViewViewModel?
    
    private(set) var child: Child
    
    // MARK: - Init
    
    init(child: Child) {
        self.child = child
    }
    
    // MARK: - Public methods
    
    func configureItemViewModel(_ type: ItemType) -> ItemViewViewModel {
        let itemViewModel: ItemViewViewModel
        switch type {
        case .name:
            itemViewModel = ItemViewViewModel(type, dynamicText: child.name)
        case .age:
            itemViewModel = ItemViewViewModel(type, dynamicText: child.age)
        }
        itemViewModel.delegate = self
        return itemViewModel
    }
    
    func didTapDeleteButton() {
        delegate?.childrenCellViewModelDidRequestToDeleteChild(self)
    }
    
//    func nameDidChange(text: String) {
//        child.name = text
//        delegate?.childrenCellViewModelDidRequestToChangeChildName(self)
//    }
}

// MARK: - ItemViewViewModelDelegate

extension FormChildrenCellViewModel: ItemViewViewModelDelegate {
    func itemViewModelDidRequestToChangeTextField(_ itemViewModel: ItemViewViewModel, text: String, type: ItemType) {
        switch type {
        case .name:
            child.name = text
//            delegate?.childrenCellViewModelDidRequestToChangeChildName(self)
        case .age:
            child.age = text
        }
        delegate?.childrenCellViewModelDidRequestToChangeData(self, type: type, child: child)
//        child.name = nameText
//        delegate?.childrenCellViewModelDidRequestToChangeChildName(self)
    }
}
