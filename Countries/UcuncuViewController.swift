//
//  UcuncuViewController.swift
//  Countries
//
//  Created by L60809MAC on 20.01.2022.
//

import UIKit


class UcuncuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    public var favCountriesItemList: [CountryListItem] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCountriesItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UINib(nibName: "FavCountryCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "FavCountryCell")
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavCountryCell") as? FavCountryCellViewController {
            cell.favCountryName.text = favCountriesItemList[indexPath.row].name
            cell.indexPath = indexPath.row
            return cell
        }
        return UITableViewCell()
        
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        loadData() 
        
       
        
    }
    
    public func favButtonTapped(indexPath: Int) {
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let fvc = mainSb.instantiateViewController(withIdentifier: "main3") as! UcuncuViewController
        self.show(fvc, sender: nil)
        
        //favoriteList.append(countriesItemList[indexPath])
        /*
        if let index = isimler.index(of: "Taha") {
            isimler.remove(at: index)
        }*/
        //favori butonuna basıldığında burada liste oluştur
        //tableView.reloadData()

    }
    
    func loadData() {
        
        var newitem : CountryListItem! = CountryListItem()
        newitem.name="Türkiye"
        newitem.code = "TR"
        newitem.wikiDataId = "TR01"
        favCountriesItemList.append(newitem)
        var newitem2 : CountryListItem! = CountryListItem()
        newitem2.name="Amerika"
        newitem2.code = "USD"
        newitem2.wikiDataId = "USD01"
        favCountriesItemList.append(newitem2)
            
         tableView.reloadData()
         
  
    }
}

