//
//  MainCategoryCollectionViewCell.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/23/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func configure(for indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            categoryImageView.image = #imageLiteral(resourceName: "characters")
            categoryLabel.text = UserStrings.General.characters.capitalized
        case 1:
            categoryImageView.image = #imageLiteral(resourceName: "vehicle")
            categoryLabel.text = UserStrings.General.vehicles.capitalized
        case 2:
            categoryImageView.image = #imageLiteral(resourceName: "starship")
            categoryLabel.text = UserStrings.General.vehicles.capitalized
        default:
            break
        }
    }
}
