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

    func removeNameTitle() -> String {
        var name = self.replacingOccurrences(of: "Mr.", with: "", options: .caseInsensitive)
        name = name.replacingOccurrences(of: "Mrs.", with: "", options: .caseInsensitive)
        name = name.replacingOccurrences(of: "Ms.", with: "", options: .caseInsensitive)
        name = name.replacingOccurrences(of: "Miss", with: "", options: .caseInsensitive)
        return name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
