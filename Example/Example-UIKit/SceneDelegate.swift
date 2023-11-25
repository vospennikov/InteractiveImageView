//
//  SceneDelegate.swift
//  Example-UIKit
//
//  Created by Mikhail Vospennikov on 13.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let newScene = (scene as? UIWindowScene) else { return }

        let newWindow = UIWindow(windowScene: newScene)
        newWindow.rootViewController = ViewController()

        window = newWindow
        window?.makeKeyAndVisible()
    }
}
