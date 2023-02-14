//
//  MarketView.swift
//  MockMarket
//
//  Created by Ali Hamoud on 2/6/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

class tickerDocument: ObservableObject{
    
    static let data = tickerDocument()
    private var json: JSON = []
    @Published var Nasdaq: [String : String] = [:]
    
    func loadFile(){
        if let path = Bundle.main.path(forResource: "nasdaq-tickers", ofType: "json"){
            do {
                let jsonPath = NSData(contentsOf: URL(filePath: path))
                self.json = JSON(jsonPath!)
                for i in 0..<json.indices.count{
                    for _ in json[i]{
                        self.Nasdaq.updateValue( json[i]["Symbol"].stringValue, forKey: json[i]["Company Name"].stringValue)
                    }
                }
                //self.data = self.json!["Company Name"].arrayValue.map{$0.string!}
            }
        }
        
    }

    
}


struct MarketView: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @StateObject var dataSet = tickerDocument.data
    @StateObject var userData = Portfolio.data
    @State private var test: [String] = []
    @State private var searchAppear = false
    @State private var didSelectStock = false
    let empty: [String] = []
    @State private var searchTicker: String = ""
    @State private var tempTicker: String = ""
    @State private var tempShares: Int = 0
    @State private var tempBoughtPrice: Double = 0.0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(tickerResults, id: \.self) { symbol in
                    Button{
                        self.stockInfo.ticker = self.dataSet.Nasdaq[symbol]
                        self.didSelectStock = true
                    }label:{
                        Text("\(symbol)").searchCompletion(symbol)
                    }
                }
            }
            .overlay(
                GeometryReader{ geo in
                    VStack(spacing: 1){
                        Section{
                            TextField("Ticker", text: $tempTicker)
                            TextField("Shares", value: $tempShares, formatter: formatter)
                            TextField("Bought Pirce", value: $tempBoughtPrice, formatter: formatter)
                        } header: {
                            Text("Enter Stock Purchase")
                        }.padding()
                        Button{
                            self.userData.displayFile()
                        }label: {
                            Text("Display Json")
                        }
                        Button{
                            self.userData.appendData(ticker: self.tempTicker, shares: self.tempShares, boughtPrice: self.tempBoughtPrice)
                            self.userData.writeFile()
                        }label: {
                            Text("Write File")
                        }
                        Button{
                            self.userData.emptyFile()
                        }label: {
                            Text("Delete File")
                        }
                    }
                    ZStack{
                        //Text("User Tickers: \(self.userData.userPortfolio.keys.joined(separator: "-")) ").bold()
                            //.position(x: geo.frame(in: .global).midX , y: geo.frame(in: .global).midY)
                        Text("\(self.userData.userData?[0][1].rawString() ?? "JSON Here")")
                            .position(x: geo.frame(in: .global).midX , y: geo.frame(in: .global).midY)
                    }
                }
                
            )
            //.opacity(self.searchAppear ? 0.0 : 1.0)
        }.searchable(text: $searchTicker)
            .sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
               LoadingScreen()
            }
            .onAppear{
                
                self.userData.checkFile()
                //self.userData.writeFile()
                //self.dataSet.loadFile()
            }
        
    }
    
    var tickerResults: [String]{
        if searchTicker.isEmpty{
            return empty
        }
        else{
            return self.dataSet.Nasdaq.keys.filter{ $0.contains(searchTicker) }
        }
    }
    
    
}
