//
//  DataCellViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.05.2023.
//

import Foundation

protocol ItemViewViewModelDelegate: AnyObject {
    func itemViewModelDidRequestToChangeTextField(_ itemViewModel: ItemViewViewModel, text: String, type: ItemType)
}

class ItemViewViewModel {
    // MARK: - Properties
    
    weak var delegate: ItemViewViewModelDelegate?
    
    var staticInfoText: String
    var staticPlaceholderText: String
    var dynamicText: String?
    
    let type: ItemType
    
    // MARK: - Init
    
    init(_ type: ItemType, dynamicText: String? = "") {
        self.type = type
        self.staticInfoText = type.infoText
        self.staticPlaceholderText = type.placeholder
        self.dynamicText = dynamicText
    }
    
    // MARK: - Public methods
    
    func nameDidChange(text: String) {
        delegate?.itemViewModelDidRequestToChangeTextField(self, text: text, type: type)
    }
}
