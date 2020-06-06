//
//  ViewController.swift
//  TheBlog
//
//  Created by Marcio Garcia on 06/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import Ivorywhite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let service = Ivorywhite.shared.service(debugMode: true)
        _ = service.request(with: URL(string: "https://sym-json-server.herokuapp.com/authors")!) { result in
            switch result {
            case .success(let response):
                let responseString = String(data: response.value!, encoding: .utf8)
                print(responseString ?? "nil")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

