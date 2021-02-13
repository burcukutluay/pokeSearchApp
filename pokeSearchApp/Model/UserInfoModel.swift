//
//  UserInfoModel.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import Foundation
import KeychainSwift

final class UserInfoModel {
            
    static let shared: UserInfoModel = UserInfoModel()
    
    internal final var favoritedPokemons: [Pokemons] {
        get {
            guard let data = appDel.keychainManager.getData("favoritedPokemons") else { return [Pokemons]() }
            do {
                return try JSONDecoder().decode([Pokemons].self, from: data)
            } catch let error {
                print("Fatal error occured when decoding object")
            }
            return [Pokemons]()
        }
        set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                appDel.keychainManager.set(encodedData, forKey: "favoritedPokemons")
            } catch let error {
                print("Fatal error occured when encoding object")
            }
        }
    }
}
