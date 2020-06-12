//
//  AppDelegate.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    var imageCache = NSCache<NSString, UIImage>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appConfig = AppConfiguration()
        let networkConfig = NetworkConfiguration(baseUrl: appConfig.value(for: .baseUrl), apiToken: "")
        if appConfig.environment != .production {
            networkConfig.debugMode = true
        }
        let networkService = Services.shared.blogService(apiConfiguration: networkConfig)
        
        window = UIWindow()
        let rootViewController = AuthorsListBuilder(service: networkService).build(imageCache: imageCache)
        navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController?.navigationBar.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

