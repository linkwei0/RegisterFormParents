//
//  FormCoordinator.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class FormCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let viewModel = FormViewModel()
        let formViewController = FormViewController(viewModel: viewModel)
        navigationController.pushViewController(formViewController, animated: animated)
    }
}
