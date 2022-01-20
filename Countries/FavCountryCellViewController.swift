//
//  FavCountryCellViewController.swift
//  Countries
//
//  Created by L60809MAC on 19.01.2022.
//

import Foundation
import UIKit

class FavCountryCellViewController: UITableViewCell {
    
    
    @IBOutlet weak var favCountryName: UILabel!
    
    @IBOutlet weak var favCountryButton: UIButton!
    public var indexPath: Int!

    public var favoriteList: [CountryListItem] = []

    
    @IBAction func favCountryButtonTapped() {
        
        
        favCountryButton.setImage(UIImage(named: "star.fill"), for: .normal)

        let vc = ViewController()
        vc.favButtonTapped(indexPath: indexPath)
        
        
    }
}
