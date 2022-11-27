//
//  MainCoordinator.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    let navigationController: UINavigationController
        
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        showFormScreen(animated: animated)
    }
    
    private func showFormScreen(animated: Bool) {
        show(FormCoordinator.self, animated: animated)
    }
}
