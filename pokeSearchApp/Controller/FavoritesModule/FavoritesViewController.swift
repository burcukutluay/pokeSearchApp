//
//  FavoritesViewController.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Layout Components
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Default Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(FavoritesTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if appDel.userInfo.favoritedPokemons.count > 0 {
            return appDel.userInfo.favoritedPokemons.count
        }
        else {
            // return no result cell
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoritesTableViewCell = tableView.createCell(indexPath)
        cell.backgroundColor = UIColor.ColorPalette.secondaryBackgroundColor
        if appDel.userInfo.favoritedPokemons.count > 0 {
            let data = appDel.userInfo.favoritedPokemons[indexPath.row]
            cell.descriptionLabel.text = data.description
            let url = URL(string: data.imageURLString!)
            getData(from: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    cell.imageView?.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            }
            
            
        }
        else {
            cell.descriptionLabel.text = "no favorited poke"
        }
        
        return cell
    }
    
    // MARK:- Network Functions
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
