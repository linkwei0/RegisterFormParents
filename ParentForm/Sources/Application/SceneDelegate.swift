//
//  SceneDelegate.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var mainCoordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        mainCoordinator = createMainCoordinator(scene: windowScene)
        mainCoordinator?.start(animated: false)
    }
    
    private func createMainCoordinator(scene: UIWindowScene) -> MainCoordinator {
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return MainCoordinator(navigationController: navigationController)
    }
}
