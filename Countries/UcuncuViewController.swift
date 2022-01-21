

import UIKit


class UcuncuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    public var favCountriesItemList: [CountryListItem] = []
    public var allCountries: [CountryListItem] = []
    
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
        //getData()
       
        tableView.reloadData()
    }
    
    public func favButtonTapped(indexPath: Int) {
        getData()
        var favCountriesItemList: [CountryListItem] = []
        
        var allCountries: [CountryListItem] = []
        
        var newitem : CountryListItem! = CountryListItem()
        newitem.name="Türkiye"
        newitem.code = "TR"
        newitem.wikiDataId = "TR01"
        allCountries.append(newitem)
        var newitem2 : CountryListItem! = CountryListItem()
        newitem2.name="Amerika"
        newitem2.code = "USD"
        newitem2.wikiDataId = "USD01"
        allCountries.append(newitem2)
        var newitem3 : CountryListItem! = CountryListItem()
        newitem.name="İngiltere"
        newitem.code = "TR"
        newitem.wikiDataId = "TR01"
        allCountries.append(newitem)
        var newitem4 : CountryListItem! = CountryListItem()
        newitem2.name="İspanya"
        newitem2.code = "USD"
        newitem2.wikiDataId = "USD01"
        allCountries.append(newitem2)
        var newitem5 : CountryListItem! = CountryListItem()
        newitem2.name="Almanya"
        newitem2.code = "USD"
        newitem2.wikiDataId = "USD01"
        allCountries.append(newitem2)
        
        var item = allCountries[indexPath]
        
        if let index = favCountriesItemList.firstIndex(where: {$0.code == item.code}) {
            favCountriesItemList.remove(at: index)
        }else{
            favCountriesItemList.append(item)
        }
        
        //tableView.reloadData()
        //favCountriesItemList.append(allCountries[indexPath])
        /*
        if let index = favCountriesItemList.index(of: "Taha") {
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
                                           let response = try JSONDecoder().decode(CountryList.Response.self, from: data)
                                           
                                           guard let countries = response.data ,
                                               let country = countries as? [CountryListItem] else
                                           {
                                               return
                                           }
                                           self.allCountries.append(contentsOf: country)
                                           debugPrint(self.allCountries)
                                       } catch  {
                                           debugPrint(error)
                                       }
            }
            }
        })
        dataTask.resume()
    }
}

