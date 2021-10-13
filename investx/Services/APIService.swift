//
//  APIService.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import Foundation
import Combine


struct APIService {
    
    enum APIServiceError: Error {
        case encoding
        case badRequest
    }
    
    var API_KEY: String {
        return API_KEYS.randomElement() ?? "715ZO76Y4PH4K7DZ"
    }
    
    let API_KEYS = ["715ZO76Y4PH4K7DZ", "MW5UPHQPRFOZ0U8B", "QXPZE8WKTU4ZN5XY", "NBKESA9O116L9WLB"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        
        var keyword = String()
        
        switch parseQuery(text: keywords) {
        case .success(let query):
            keyword = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keyword)&apikey=\(API_KEY)"

        switch parseURL(urlString: urlString){
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({ $0.data })
                .decode(type: SearchResults.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchTimeSeriesMonthlyAdjustedPublisher(keywords: String) -> AnyPublisher<TimeSeriesMonthlyAdjusted, Error> {
       
        var keyword = String()
        
        switch parseQuery(text: keywords) {
        case .success(let query):
            keyword = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(keyword)&apikey=\(API_KEY)"
        
        
        
        switch parseURL(urlString: urlString){
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({ $0.data })
                .decode(type: TimeSeriesMonthlyAdjusted.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
    }
    
    private func parseQuery(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        }
        else {
            return .failure(APIServiceError.encoding)
        }
    }
    
    private func parseURL(urlString: String) -> Result<URL, Error>{
        if let url = URL(string: urlString){
            return .success(url)
        }
        return .failure(APIServiceError.badRequest)
        
    }
    
    
}
