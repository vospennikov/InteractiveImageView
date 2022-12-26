//
//  SceneDelegate.swift
//  Example
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let newWindow = UIWindow(windowScene: windowScene)
            newWindow.rootViewController = UIHostingController(rootView: contentView)
            newWindow.makeKeyAndVisible()
            window = newWindow
        }
    }
}
