//
//  FavoritesTableViewCell.swift
//  pokeSearchApp
//
//  Created by burcu kirik on 7.02.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView?.image = nil
        self.lineView.backgroundColor = UIColor.ColorPalette.backgroundColor
        self.descriptionLabel.textColor = UIColor.ColorPalette.labelColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
