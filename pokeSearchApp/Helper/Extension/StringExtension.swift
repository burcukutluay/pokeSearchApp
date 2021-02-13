//
//  StringExtension.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import Foundation

public extension String {
    func queryAllowed() -> String? {
        return folding(options: .diacriticInsensitive, locale: .current).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
