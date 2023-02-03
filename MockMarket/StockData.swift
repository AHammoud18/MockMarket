//
//  PythonData.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 1/20/23.
//

import Foundation
import SwiftUI
import XCAStocksAPI

@available(iOS 16.0, *)
@MainActor class StockData: ObservableObject{
    static let data = StockData()
    @Published var stockData: [[Indicator]] = [[]]  // matrix of indicators [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockTicker: [Quote] = []
    @Published var stockPrice: [[Double]] = [[]] // matrix of Prices [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockDates: [[String]] = [[]] // matrix of Dates [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockDayTimes: [String] = []
    @Published var ticker: String?
    @Published var range: ChartRange?
    // variables below are for market time comparison
    let calendar = Calendar.current
    let now = Date()
    @Published var currentTime = ""
    @AppStorage ("marketTime") var isMarketOpen = false
    var timeH = 9
    var timeM = 30
    var dateComponents = DateComponents()
    var date: [String] = []
    let dateFormat = DateFormatter()
    let timeFormat = DateFormatter()
    
    func grabStockInfo(){
        Task{
            let api = XCAStocksAPI()
            self.stockData[0] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: self.range ?? .oneDay)!.indicators
            loadPrices()
        }
    }
    
    func refreshStock(){
        //loadTicker()
        print("hi")
        debugPrint(self.stockTicker)
        self.stockPrice[0].append(self.stockTicker.last!.regularMarketPrice!)
    }
    
    func deintitStock(){
        self.stockPrice = [[]]
        self.stockDayTimes.removeAll()
        self.stockDates = [[]]
        print("removed!")
    }
    
    
    // this function will append price data, date data and hour data from the "data" variable
    func loadPrices(){
        timeFormat.timeStyle = .short
        dateFormat.dateFormat = "yy-MM-dd"

        // append all day values to the first index in the matrix
        for i in 0..<self.stockData[0].count-1{
            self.stockDates[0].insert(dateFormat.string(from: self.stockData[0][i].timestamp), at: i)
            self.stockDayTimes.insert(timeFormat.string(from: self.stockData[0][i].timestamp), at: i)
            self.stockPrice[0].insert(self.stockData[0][i].close, at: i)
        }
        
        print(self.stockPrice[0])
    }
    
    
    func getTime(){
        self.currentTime = timeFormat.string(from: now)
        let marketOpenTime = calendar.date(bySettingHour: 9, minute: 30, second: 00, of: now)!
        let marketCloseTime = calendar.date(bySettingHour: 16, minute: 00, second: 00, of: now)!
        
        if now >= marketOpenTime && now <= marketCloseTime{
            isMarketOpen = true
            refreshStock()
        }
        else{
            isMarketOpen = false
        }
    }
    
    
    func loadTicker(){
        Task{
            let api = XCAStocksAPI()
            self.stockTicker = try await api.fetchQuotes(symbols: self.ticker ?? "")
        }
    }
    
}
