//
//  ViewController.swift
//  Countries
//
//  Created by L60809MAC on 18.01.2022.
//

import UIKit

protocol CountryListDisplayLogic: class {
    func displayCountryList(response: GetCountriesList.CountryList.Response?)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var countriesItemList: [CountryListItem] = []
    public var allCountries: [CountryListItem] = []
    var response: GetCountriesList.CountryList.Response? {
            didSet {
                guard let countries = response?.data ,
                    let country = countries as? [CountryListItem] else
                {
                    return
                }
                countriesItemList.append(contentsOf: country)
            }
        }
    
    var allresponse: GetCountriesList.CountryList.Response? {
        didSet {
            guard let countries = allresponse?.data ,
                let country = countries as? [CountryListItem] else
            {
                return
            }
            allCountries.append(contentsOf: country)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UINib(nibName: "CountryCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CountryCell")
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCellViewController {
            cell.countryName.text = countriesItemList[indexPath.row].name
            cell.indexPath = indexPath.row
            return cell
        }
        return UITableViewCell()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
      }
            
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        // Eğer editleme stili "delete" ise seçilen cell'i silmesi gerektiğini söyleyen şartlı yapı
        if editingStyle == .delete {
            
            var newitem : CountryListItem! = CountryListItem()
            newitem.name="Türkiye"
            newitem.code = "TR"
            newitem.wikiDataId = "TR01"
            //favoriteList.append(newitem)
            
            /*//Seçilen cell'deki elemanı dizi içinden de siliyoruz.
             favoriteList.remove(at: indexPath.row)
            //TableView içinden siliyoruz
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)*/
         }
         
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //countriesItemList[indexPath.row].code
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "main2") as! IkinciViewController
        vc.selectedCountryCode = countriesItemList[indexPath.row].code ?? ""
        vc.countriesItemList2 = countriesItemList
        self.show(vc, sender: nil)
        

    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelBir: UILabel!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Countries"
        
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        
        /*//Edit Button (Hazır bir buton kullancağız)
        let editButton = editButtonItem
        //Butonumuzun rengini belirledik
        editButton.tintColor = UIColor.black
        //Butonu nereye ekleyeceğimizi seçiyoruz
        self.navigationItem.leftBarButtonItem = editButton*/
        
    }

    func displayCountryList(response: GetCountriesList.CountryList.Response?) {
          self.response = response
          tableView.reloadData()
          //waiting = false
      }
    
    func loadData() {
        
        /*var newitem : CountryListItem! = CountryListItem()
        newitem.name="Türkiye"
        newitem.code = "TR"
        newitem.wikiDataId = "TR01"
        countriesItemList.append(newitem)
        var newitem2 : CountryListItem! = CountryListItem()
        newitem2.name="Amerika"
        newitem2.code = "USD"
        newitem2.wikiDataId = "USD01"
        countriesItemList.append(newitem2)
            
         tableView.reloadData()
         */
        
        let headers = [
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
            "x-rapidapi-key": "42ac15c7edmsh99aaaaaff30c900p134fe3jsn67ceb76952fc"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let data = data {
                                       
                                       do {
                                           let response = try JSONDecoder().decode(GetCountriesList.CountryList.Response.self, from: data)
                                           DispatchQueue.main.async { [weak self] in
                                               self?.response = response
                                               
                                               debugPrint(response)
                                               
                                               self?.tableView.reloadData()
                                           }
                                       } catch  {
                                           debugPrint(error)
                                       }
            }
            }
        })
        dataTask.resume()

    }

    public func favButtonTapped(indexPath: Int) {
        let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainSb.instantiateViewController(withIdentifier: "main3") as! UcuncuViewController
        getData()
        vc.favCountriesItemList.append(allCountries[indexPath])
        
        self.show(vc, sender: nil)
        /*let mainSb = UIStoryboard(name: "Main", bundle: Bundle.main)            // 1
               let thirdVC = mainSb.instantiateViewController(identifier: "main3")   // 2
               show(thirdVC, sender: nil)*/
        
        //favoriteList.append(countriesItemList[indexPath])
        /*
        if let index = isimler.index(of: "Taha") {
            isimler.remove(at: index)
        }*/
        //favori butonuna basıldığında burada liste oluştur
        //tableView.reloadData()

    }
    
    
    func getData() {
        
        
        let headers = [
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
            "x-rapidapi-key": "42ac15c7edmsh99aaaaaff30c900p134fe3jsn67ceb76952fc"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let data = data {
                                       
                                       do {
                                           let response = try JSONDecoder().decode(GetCountriesList.CountryList.Response.self, from: data)
                                           DispatchQueue.main.async { [weak self] in
                                               self?.allresponse = response
                                           }
                                       } catch  {
                                           debugPrint(error)
                                       }
            }
            }
        })
        dataTask.resume()

    }
}

