//
//  ParentViewViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 30.06.2023.
//

import Foundation

class ParentViewViewModel {
    var onDidClearName: ((_ itemViewModel: ItemViewViewModel) -> Void)?
    var onDidClearAge: ((_ itemViewModel: ItemViewViewModel) -> Void)?

    private var itemViewModels: [ItemViewViewModel] = []
    
    func clearParentData() {
        itemViewModels.forEach { itemViewModel in
            itemViewModel.dynamicText = ""
            switch itemViewModel.type {
            case .name:
                onDidClearName?(itemViewModel)
            case .age:
                onDidClearAge?(itemViewModel)
            }
        }
    }
    
    func configureItemViewModel(_ type: ItemType) -> ItemViewViewModel {
        let itemViewModel = ItemViewViewModel(type)
        itemViewModel.delegate = self
        itemViewModels.append(itemViewModel)
        return itemViewModel
    }
}

// MARK: - ItemViewViewModelDelegate

extension ParentViewViewModel: ItemViewViewModelDelegate {
    func itemViewModelDidRequestToChangeTextField(_ itemViewModel: ItemViewViewModel, text: String, type: ItemType) {
    }
}
