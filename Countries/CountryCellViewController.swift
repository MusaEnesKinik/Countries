

import Foundation
import UIKit

class CountryCellViewController: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    public var indexPath: Int!

    @IBAction func favButtonTapped() {
        
        favButton.setImage(UIImage(named: "star.fill"), for: .normal)
        
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let fvc = mainSb.instantiateViewController(withIdentifier: "main3") as! UcuncuViewController
        
        fvc.favButtonTapped(indexPath: indexPath)
        
    }
}
