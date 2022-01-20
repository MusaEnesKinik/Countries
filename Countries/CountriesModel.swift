//
//  CountriesModel.swift
//  Countries
//
//  Created by L60809MAC on 18.01.2022.
//

import Foundation

enum GetCountriesList {
    // MARK: Use cases
    
    enum CountryList {
        struct Request: Codable {
            let apiHost: String
            let apiKey: String
            let transactionUrl: String
            
            enum CodingKeys: String, CodingKey {
                case apiHost = "x-rapidapi-host"
                case apiKey = "x-rapidapi-key"
                case transactionUrl
            }
            
            init(page: Int) {
                self.apiHost = "wft-geo-db.p.rapidapi.com"
                self.apiKey = "42ac15c7edmsh99aaaaaff30c900p134fe3jsn67ceb76952fc"
                self.transactionUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
            }
        }
        
        struct Response: Codable {
            let data: [CountryListItem]?
            
            enum CodingKeys: String, CodingKey {
                case data
            }
        }
        
        struct ViewModel {
            
        }
    }
}

struct CountryListItem: Codable {
    var code: String?
    var name: String?
    var wikiDataId: String?
    
    enum CodingKeys: String, CodingKey {
            case code = "code"
            case name = "name"
            case wikiDataId = "wikiDataId"
        }
}
