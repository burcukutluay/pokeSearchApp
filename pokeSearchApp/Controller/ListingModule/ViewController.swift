//
//  ViewController.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 6.02.2021.
//

import UIKit
import pokeFW

let appDel = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController, UISearchBarDelegate  {
    
    // MARK: - Layout Components
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var searchBar:UISearchBar!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let url = "\(infoView.descriptionImageURL!)"
        if checkIfFav() {
            self.deleteFavoritedPokemons(pokeUrl: url)
        }
        else {
            self.addFavoritedPokemons(pokeUrl: url, pokeDescription: infoView.descriptionText)
        }
    }
    
    var infoView = InfoView()
    
    // MARK: - Default Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = UIColor.ColorPalette.backgroundColor
        self.searchBar.backgroundColor = UIColor.ColorPalette.secondaryBackgroundColor
        self.searchBar.searchTextField.backgroundColor = UIColor.ColorPalette.secondaryBackgroundColor
        self.searchBar.placeholder = "Search a Pokemon by name"
        searchBar.delegate = self
    }
    
    // MARK: - Layout Functions
    
    func arrangeSearchResultView(keyword: String) {
        if keyword.count > 0 {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            let infoSubView = InfoView.init(frame: CGRect(x: 0, y: 75, width: screenWidth, height: screenHeight - 200))
            self.infoView = infoSubView
            self.infoView.backgroundColor = UIColor.clear
            self.contentView.addSubview(infoSubView)
            self.favoriteButton.bringSubviewToFront(contentView)
            infoView.getAndSetResultView(keyword: keyword)
            self.reloadInputViews()
        }
        else {
            self.deleteInfoView()
        }
    }
    
    func deleteInfoView() {
        for item in self.contentView.subviews {
            if item.classForCoder == pokeFW.InfoView.classForCoder() {
                item.removeFromSuperview()
            }
        }
        self.reloadInputViews()
    }
        
    // MARK: - SearchBar Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count ?? 0 < 2 {
            self.deleteInfoView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.arrangeSearchResultView(keyword: searchBar.text ?? "")
    }
    
    // MARK: - Keychain Functions
    
    fileprivate func deleteFavoritedPokemons(pokeUrl: String) {
        var list: [Pokemons] = appDel.userInfo.favoritedPokemons
        if list.count > 0 {
            if list.count > 1 {
                for i in 0...list.count - 1 {
                    if list[i].imageURLString == pokeUrl {
                        list.remove(at: i)
                        return
                    }
                }
            }
            else {
                if list[0].imageURLString == pokeUrl {
                    list.remove(at: 0)
                }
            }
        }
        appDel.userInfo.favoritedPokemons = list
    }
    
    fileprivate func addFavoritedPokemons(pokeUrl: String, pokeDescription: String) {
        var list: [Pokemons] = appDel.userInfo.favoritedPokemons
        var poke = Pokemons()
        poke.description = pokeDescription
        poke.imageURLString = pokeUrl
        list.append(poke)
        appDel.userInfo.favoritedPokemons = list
    }
    
    // MARK: - Favorite Functions
    
    func checkIfFav() -> Bool {
        let list: [Pokemons] = appDel.userInfo.favoritedPokemons
        var poke = Pokemons()
        poke.description = infoView.descriptionText
        let url = "\(infoView.descriptionImageURL!)"
        poke.imageURLString = url
        
        if list.contains(where: { $0.description == poke.description }) {
            return true
        }
        return false
    }
}


