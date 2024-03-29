//
//  SearchResults.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import Foundation


struct SearchResults: Decodable {
    let items: [SearchResult]
    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
    
    
    
}


struct SearchResult: Decodable {
    let ticker: String
    let name: String
    let type: String
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case ticker = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}
