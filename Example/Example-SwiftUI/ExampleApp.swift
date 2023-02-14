//
//  ExampleApp.swift
//  Example
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import UIKit

@main
struct ExampleApp {
    static func main() {
        if #available(iOS 14.0, *) {
            ExampleAppWindowGroup.main()
        } else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(SceneDelegate.self))
        }
    }
}
