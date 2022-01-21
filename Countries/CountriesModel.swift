

import Foundation

    enum CountryList {
        
        struct Response: Codable {
            let data: [CountryListItem]?
            
            enum CodingKeys: String, CodingKey {
                case data
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
