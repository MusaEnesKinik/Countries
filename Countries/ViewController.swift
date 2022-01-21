

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var countriesItemList: [CountryListItem] = []
    public var allCountries: [CountryListItem] = []
    
    var response: CountryList.Response? {
            didSet {
                guard let countries = response?.data ,
                    let country = countries as? [CountryListItem] else
                {
                    return
                }
                countriesItemList.append(contentsOf: country)
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
            allCountries.append(newitem)
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "main3") as! UcuncuViewController
            vc.favCountriesItemList = self.allCountries
            self.show(vc, sender: nil)
            
            /*//Seçilen cell'deki elemanı dizi içinden de siliyoruz.
             favoriteList.remove(at: indexPath.row)
            //TableView içinden siliyoruz
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)*/
         }
         
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    }
    
    func loadData() {
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
    
}

