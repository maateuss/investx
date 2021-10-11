//
//  SearchCellViewModel.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import Foundation

struct SearchCellViewModel {
    private let searchResult : SearchResult
    
    init(searchResult: SearchResult){
        self.searchResult = searchResult
    }
    var name: String {
        return searchResult.name
    }
    
    var typeDefinition: String {
        return searchResult.type.appending(" ").appending(searchResult.currency)
    }
    
    var ticker: String {
        return searchResult.ticker
    }
    
    
}
