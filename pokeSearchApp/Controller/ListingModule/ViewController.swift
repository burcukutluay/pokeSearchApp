//
//  ViewController.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 6.02.2021.
//

import UIKit
import pokeFW

let appDel = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController, UISearchBarDelegate, InfoViewDelegate  {
        
    // MARK: - Layout Components
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var searchBar:UISearchBar!
    @IBOutlet weak var scrollContentView: UIScrollView!
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
        self.favoriteButton.isHidden = true
        self.searchBar.delegate = self
        // to prevent _UITemporaryLayoutWidth error init with frame & give width for infoView
        self.infoView = InfoView.init(frame: CGRect(x: 0, y: 75, width: screenWidth, height: 0))
        self.infoView.infoViewDelegate = self
    }
    
    // MARK: - Layout Functions
    
    func arrangeSearchResultView(keyword: String) {
        if keyword.count > 0 {
            infoView.getAndSetResultView(keyword: keyword)
        }
        else {
            self.deleteInfoView()
        }
    }
    
    func deleteInfoView() {
        self.favoriteButton.isHidden = true
        for item in self.scrollContentView.subviews {
            if item.classForCoder == pokeFW.InfoView.classForCoder() {
                item.removeFromSuperview()
            }
        }
        self.infoView.deleteSubviews()
        self.reloadInputViews()
    }
    
    func arrangeFavoriteButton() {
        self.favoriteButton.isHidden = false
        self.favoriteButton.bringSubviewToFront(contentView)
        if self.checkIfFav() {
            self.favoriteButton.setTitle("Remove From Favorites", for: .normal)
        }
        else {
            self.favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
    }
    
    // MARK: - InfoViewDelegate Functions
    
    func viewShouldReturn(view: InfoView, height: CGFloat) {
        self.infoView = view
        self.infoView.backgroundColor = UIColor.clear
        self.infoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: height)
        self.scrollContentView.addSubview(infoView)
        // to enable scroll view
        self.scrollContentView.contentSize = CGSize(width: screenWidth, height: height)
        self.arrangeFavoriteButton()
    }
    
    func emptyViewShouldReturn(errorMessage: String, type: String) {
        var title = "No Data"
        if type == "Error" {
            title = "Error"
        }
        
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SearchBar Delegate Functions
    
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
        self.arrangeFavoriteButton()
    }
    
    fileprivate func addFavoritedPokemons(pokeUrl: String, pokeDescription: String) {
        var list: [Pokemons] = appDel.userInfo.favoritedPokemons
        var poke = Pokemons()
        poke.description = pokeDescription
        poke.imageURLString = pokeUrl
        list.append(poke)
        appDel.userInfo.favoritedPokemons = list
        self.arrangeFavoriteButton()
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


