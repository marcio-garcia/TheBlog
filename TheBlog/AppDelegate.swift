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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appConfig = AppConfiguration()
        let networkConfig = NetworkConfiguration(baseUrl: appConfig.value(for: .baseUrl), apiToken: "")
        let networkService = Services.shared.blogService(apiConfiguration: networkConfig)
        
        window = UIWindow()
        window?.rootViewController = AuthorsListBuilder(service: networkService).build()
        window?.makeKeyAndVisible()
        return true
    }
}

