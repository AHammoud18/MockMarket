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
    @Published var chartRange: Int?
    @Published var stockData: [[Indicator]] = [[], [], [], [], [], []]  // matrix of indicators [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockTicker: [Quote] = []
    @Published var stockPrice: [[Double]] = [[], [], [], [], [], []] // matrix of Prices [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockDates: [[String]] = [[], [], [], [], [], []] // matrix of Dates [0] = Day, [1] = week, [2] = month...etc...
    @Published var stockDayTimes: [String] = []
    @Published var currentPrices: [Double]? = []
    @Published var ticker: String?
    @Published var range: ChartRange?
    @Published var isLoaded = false
    @Published var loadedQuote = false
    @Published var result = 0.0
    // variables below are for market time comparison
    let calendar = Calendar.current
    let now = Date()
    @Published var currentTime = ""
    @AppStorage ("marketTime") var isMarketOpen = false
    var dateComponents = DateComponents()
    var date: [String] = []
    let dateFormat = DateFormatter()
    let timeFormat = DateFormatter()
    
    func grabStockInfo(){
        Task{
            let api = XCAStocksAPI()
            // stock info for a day
            self.stockData[0] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .oneDay)!.indicators
            // stock info for a week
            self.stockData[1] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .oneWeek)!.indicators
            // stock info for a month
            self.stockData[2] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .oneMonth)!.indicators
            // 6 months
            self.stockData[3] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .sixMonth)!.indicators
            // one year
            self.stockData[4] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .oneYear)!.indicators
            // max
            self.stockData[5] = try await api.fetchChartData(tickerSymbol: self.ticker ?? "", range: .max)!.indicators
            
            loadPrices()
            
        }
    }
    
    func refreshStock(){
        loadTicker()
        self.stockPrice[0].append(self.stockTicker.last!.regularMarketPrice!)
    }
    
    func deintitStock(){
        self.isLoaded = false
        self.ticker = ""
        self.stockData = [[], [], [], [], [], []]
        self.stockPrice = [[], [], [], [], [], []]
        self.stockDayTimes.removeAll()
        self.stockDates = [[], [], [], [], [], []]
        print("removed!")
    }
    
    
    // this function will append price data, date data and hour data from the "data" variable
    func loadPrices(){
        if !(self.stockData[0].isEmpty){
            self.isLoaded = true
            print("loaded")
            
        }
        timeFormat.timeStyle = .short
        dateFormat.dateFormat = "yy-MM-dd"

        if !(self.stockData[0].isEmpty){
            for i in 0..<6{
                
                // append all day values to the first index in the matrix (for day view)
                for j in 0..<self.stockData[i].count-1{
                    self.stockDates[i].insert(dateFormat.string(from: self.stockData[i][j].timestamp), at: j)
                    self.stockDayTimes.insert(timeFormat.string(from: self.stockData[i][j].timestamp), at: j)
                    self.stockPrice[i].insert(self.stockData[i][j].close, at: j)
                }
            }
        }else{
            print("Error! Not enough stock information")
            debugPrint(self.stockData[1].count)
            debugPrint(self.stockData[0].count)
        }
        
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
    
    @MainActor func loadTickerforUser(ticker: String){
        Task{
            self.currentPrices = []
            let api = XCAStocksAPI()
            self.result = try await api.fetchQuotes(symbols: ticker).last!.regularMarketPrice!
            print("results: \(self.result)")
            self.currentPrices?.append(self.result)
        }
    }
    
    func loadTicker(){
        Task{
            let api = XCAStocksAPI()
            self.stockTicker = try await api.fetchQuotes(symbols: self.ticker ?? "")
        }
    }
    
}
