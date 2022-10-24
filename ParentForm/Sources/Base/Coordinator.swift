//
//  Coordinator.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    init(navigationController: UINavigationController)
    
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    var onDidFinish: (() -> Void)? { get set }
    
    func start(animated: Bool)
    func add(_ coordinator: Coordinator)
    func remove(_ coordinator: Coordinator)
    
    func show<T: Coordinator>(_ type: T.Type, animated: Bool) -> T
}

extension Coordinator {
    func add(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    @discardableResult
    func show<T: Coordinator>(_ type: T.Type, animated: Bool) -> T {
        let coordinator = T(navigationController: navigationController)
        startCoordinator(coordinator, animated: animated)
        return coordinator
    }
    
    func startCoordinator(_ coordinator: Coordinator, animated: Bool) {
        add(coordinator)
        coordinator.onDidFinish = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            coordinator.handleCoordinatorFinished()
            self?.remove(coordinator)
        }
        coordinator.start(animated: animated)
    }
    
    func handleCoordinatorFinished() {
        // Do nothing
    }
}

