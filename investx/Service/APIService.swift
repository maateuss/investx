//
//  APIService.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import Foundation
import Combine


struct APIService {
    var API_KEY: String {
        return API_KEYS.randomElement() ?? "715ZO76Y4PH4K7DZ"
    }
    
    let API_KEYS = ["715ZO76Y4PH4K7DZ", "MW5UPHQPRFOZ0U8B", "QXPZE8WKTU4ZN5XY", "NBKESA9O116L9WLB"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
