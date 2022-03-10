//
//  AppDelegate.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 08/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var windows: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.windows = UIWindow(frame: UIScreen.main.bounds)
        self.windows?.rootViewController = MainController()
        self.windows?.makeKeyAndVisible()
        return true
    }



}

