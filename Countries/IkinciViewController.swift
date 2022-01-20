//
//  IkinciViewController.swift
//  Countries
//
//  Created by L60809MAC on 18.01.2022.
//

import UIKit

class IkinciViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    public var selectedCountryCode: String = ""
    public var countriesItemList2: [CountryListItem] = []
    var wikiId: String = "Q30"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedCountry = countriesItemList2.first(where: {$0.code == selectedCountryCode})
        label?.text = selectedCountry?.code
        button.setTitle("For More Information ->", for: .normal)
        wikiId = (selectedCountry?.wikiDataId)!
    }
    
    
    @IBAction func moreInfoButtonTapped(_ sender: Any) {
        let url = String(format: "%@", "https://www.wikidata.org/wiki/", self.wikiId )
        UIApplication.shared.openURL(NSURL(string: url)! as URL)

    }

}
