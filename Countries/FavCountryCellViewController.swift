

import Foundation
import UIKit

class FavCountryCellViewController: UITableViewCell {
    
    
    @IBOutlet weak var favCountryName: UILabel!
    
    @IBOutlet weak var favCountryButton: UIButton!
    
    public var indexPath: Int!

    public var favoriteList: [CountryListItem] = []

    
    @IBAction func favCountryButtonTapped() {
        favCountryButton.setImage(UIImage(named: "star.fill"), for: .normal)
        
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let fvc = mainSb.instantiateViewController(withIdentifier: "main3") as! UcuncuViewController
        
        fvc.favButtonTapped(indexPath: indexPath)
        
    }
}
