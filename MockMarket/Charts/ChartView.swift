//
//  ChartView.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 2/3/23.
//
//
import Foundation
import SwiftUI
import XCAStocksAPI

@available(iOS 16.0, *)
struct Chart: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var progress: Double = 0.0
    @State private var loaded = false
    @State var ticker: String?
    let calendar = Calendar.current
    let now = Date()
    @State var currentTime = ""
    @AppStorage ("marketTime") var isMarketOpen = false
    let dateFormat = DateFormatter()
    let timeFormat = DateFormatter()
    @State var range: Int
    
    init(range: Int){
        _range = State(initialValue: range)
    }
    // creates an initializer asking for the ticker symbol and the range of the chart
    
    var body: some View{
        ZStack{
            stockView
            }
        }
    
    var stockView: some View{
        GroupBox{
            LineChartView(
                lineChartController:
                    LineChartController(
                        prices: self.stockInfo.stockPrice[self.range],
                        dates: self.stockInfo.stockDates[self.range],
                        hours: self.stockInfo.stockDayTimes,
                        indicatorPointColor: self.pointPos.indicatorColor,
                        dragGesture: true
                    ))
        }.groupBoxStyle(ChartBox())
        .onReceive(timer){ _ in
            self.stockInfo.getTime()
    }
    }
}

@available(iOS 16.0, *)
struct ChartLineView: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var progress: Double = 0.0
    @State private var loaded = false
    let calendar = Calendar.current
    let now = Date()
    @State var currentTime = ""
    @AppStorage ("marketTime") var isMarketOpen = false
    let dateFormat = DateFormatter()
    let timeFormat = DateFormatter()
    @State var range: Int = 0
    @State var ticker: String

    
    init(ticker: String){
        _ticker = State(initialValue: ticker)
        
    }
    // creates an initializer asking for the ticker symbol and the range of the chart
    
    var body: some View{
        ZStack{
            stockView
        }.onAppear{
            self.stockInfo.ticker = ticker
            loadStock()
            }
        
        }
    
    func loadStock(){
        self.stockInfo.range = .oneDay
        self.stockInfo.grabStockInfo()
        self.stockInfo.loadTicker()
    }
    
    var stockView: some View{
            LineChartView(
                lineChartController:
                    LineChartController(
                        prices: self.stockInfo.stockPrice[self.range],
                        dates: self.stockInfo.stockDates[self.range],
                        hours: self.stockInfo.stockDayTimes,
                        indicatorPointColor: self.pointPos.indicatorColor,
                        dragGesture: false
                    )).onReceive(timer){ _ in
                        self.stockInfo.getTime()
                }
    }
}
