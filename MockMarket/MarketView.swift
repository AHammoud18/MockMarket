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
        ZStack{
            NavigationView{
                List{
                    ForEach(tickerResults, id: \.self) { symbol in
                        Button{
                            print("Clicked")
                            self.stockInfo.ticker = self.dataSet.Nasdaq[symbol]
                            self.didSelectStock = true
                        }label:{
                            Text("\(symbol)").searchCompletion(symbol)
                        }
                    }
                }
            }
            .searchable(text: $searchTicker, prompt: "Search Mock Market...")
            .sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
                   LoadingScreen()
                }
        }
        .onAppear{
            self.dataSet.loadFile()
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
