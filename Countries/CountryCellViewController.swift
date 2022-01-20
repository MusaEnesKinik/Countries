//
//  CountryCellViewController.swift
//  Countries
//
//  Created by L60809MAC on 18.01.2022.
//

import Foundation
import UIKit

class CountryCellViewController: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    public var indexPath: Int!

    @IBAction func favButtonTapped() {
        
        
        favButton.setImage(UIImage(named: "star.fill"), for: .normal)
        
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let fvc = mainSb.instantiateViewController(withIdentifier: "main1") as! ViewController
        
        fvc.favButtonTapped(indexPath: indexPath)
        
        
    }
}
