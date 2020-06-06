//
//  ViewController.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let config = AppConfiguration()
        print(config.environment)
        print(config.value(for: .baseUrl))
        print(config.value(for: .appVersion))
        print(config.value(for: .bundleId))
    }


}

