//
//  ViewController.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Services

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let appConfig = AppConfiguration()
        let networkConfig = NetworkConfiguration(baseUrl: appConfig.value(for: .baseUrl), apiToken: "")
        let service = Services.shared.blogService(apiConfiguration: networkConfig)
        service.requestAuthors { authors, error in
            print(authors)
        }
    }
}

