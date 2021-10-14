//
//  TimeSeriesMonthlyAdjusted.swift
//  investx
//
//  Created by Mateus Santos on 13/10/21.
//

import Foundation

struct MonthInfo {
    let date: Date
    var adjustedOpen : Double { return (adjustedClose/close)*self.open  }
    let open : Double
    let close : Double
    let adjustedClose : Double
}

struct TimeSeriesMonthlyAdjusted : Decodable {
    let meta: Meta
    let timeSeries: [String: OHLC]
    
    enum CodingKeys: String, CodingKey{
        case meta = "Meta Data"
        case timeSeries = "Monthly Adjusted Time Series"
    }
    
    func getSortedMonthInfos() -> [MonthInfo] {
        let sorted = timeSeries.sorted { $0.key > $1.key }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return sorted.map({ dateValuePair in
            let date = dateFormatter.date(from: dateValuePair.key),
            openValue = (dateValuePair.value.open as NSString).doubleValue,
            adjCloseValue = (dateValuePair.value.adjustedClose as NSString).doubleValue,
            close = (dateValuePair.value.close as NSString).doubleValue
            
            return MonthInfo(date: date ?? Date(), open: openValue, close: close, adjustedClose: adjCloseValue)
        })
    
    }
    
}


struct Meta : Decodable {
    let symbol: String
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC : Decodable {
    let open: String
    let close: String
    let adjustedClose: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}
