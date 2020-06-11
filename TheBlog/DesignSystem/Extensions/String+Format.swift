//
//  String+Format.swift
//  TheBlog
//
//  Created by Marcio Garcia on 11/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

extension String {
    func initials() -> String {
        let splitted = self.split(separator: " ")
        let firstString = splitted.first
        let secondString = splitted.last
        let firstChar = firstString?.prefix(1)
        let secondChar = secondString?.prefix(1)
        return "\(firstChar ?? "")\(secondChar ?? "")"
    }
}
