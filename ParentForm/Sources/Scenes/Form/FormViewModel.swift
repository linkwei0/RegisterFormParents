//
//  FormViewModel.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import Foundation

final class FormViewModel {
    // MARK: - Properties
    
    var updateData: (() -> Void)?
    var updateAddButton: ((_ flag: Bool) -> Void)?
    
    private var children: [Child] = []
    
    // MARK: - Public methods
    
    func numberOfRowsInSection(section: Int) -> Int {
        return children.count
    }
    
    func cellDefinition(indexPath: IndexPath) -> FormCellViewModel {
        let cellViewModel = FormCellViewModel(child: children[indexPath.row])
        cellViewModel.delegate = self
        return cellViewModel
    }
    
    func addChild() {
        if children.count < 5 {
            let child = Child(name: "Test Name", age: "Test Age")
            children.append(child)
            children.count == 5 ? updateAddButton?(true) : updateAddButton?(false)
            updateData?()
        } else {
            updateAddButton?(true)
        }
    }
    
    func clearChildren() {
        children.removeAll()
        updateData?()
        updateAddButton?(false)
    }
}

// MARK: - FormCellViewModelDelegate

extension FormViewModel: FormCellViewModelDelegate {
    func formCellViewModelDidRequestToDeleteChild(_ viewModel: FormCellViewModel) {
        if let index = children.firstIndex(where: { child in
            child == viewModel.child
        }) {
            children.remove(at: index)
        }
        updateData?()
        children.count == 5 ? updateAddButton?(true) : updateAddButton?(false)
    }
}
