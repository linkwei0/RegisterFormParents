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
    var deleteData: (() -> Void)?
    var updateAddButton: ((_ flag: Bool) -> Void)?
    
    private(set) var footerViewModel = FormFooterViewModel()
    
    private var children: [Child] = []
    
    var parentViewModel = ParentViewViewModel()
        
    // MARK: - Init
    
    init() {
        footerViewModel.delegate = self
    }
    
    // MARK: - Public methods
    
    func numberOfRowsInSection(section: Int) -> Int {
        return children.count
    }
    
    func configureCellViewModel(with indexPath: IndexPath) -> FormChildrenCellViewModel {
        let cellViewModel = FormChildrenCellViewModel(child: children[indexPath.row])
        cellViewModel.delegate = self
        return cellViewModel
    }
    
    func addChild() {
        if children.count < 5 {
            let child = Child(name: "", age: "", date: Date())
            children.append(child)
            children.count == 5 ? updateAddButton?(true) : updateAddButton?(false)
            updateData?()
        } else {
            updateAddButton?(true)
        }
    }
    
    func removeAllChildren() {
        children.removeAll()
        parentViewModel.clearParentData()
        updateData?()
        updateAddButton?(false)
    }
}

// MARK: - FormCellViewModelDelegate

extension FormViewModel: FormChildrenCellViewModelDelegate {
    func childrenCellViewModelDidRequestToChangeData(_ viewModel: FormChildrenCellViewModel,
                                                          type: ItemType, child: Child) {
        
        if let index = children.firstIndex(where: { child in
            child.date == viewModel.child.date
        }) {
            switch type {
            case .name:
                children[index].name = viewModel.child.name
            case .age:
                children[index].age = viewModel.child.age
            }
        }
        children.count == 5 ? updateAddButton?(true) : updateAddButton?(false)
    }
    
    func childrenCellViewModelDidRequestToDeleteChild(_ viewModel: FormChildrenCellViewModel) {
        if let index = children.firstIndex(where: { child in
            child.date == viewModel.child.date
        }) {
            children.remove(at: index)
        }
        updateData?()
        children.count == 5 ? updateAddButton?(true) : updateAddButton?(false)
    }
}

// MARK: - FormFooterViewModelDelegate

extension FormViewModel: FormFooterViewModelDelegate {
    func viewModelDidRequestToDeleteData(_ viewModel: FormFooterViewModel) {
        deleteData?()
    }
}
