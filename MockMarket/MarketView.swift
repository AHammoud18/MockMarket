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
    @Published var SP500: [String : String] = [:]
    
    func loadFile(){
        if let path = Bundle.main.path(forResource: "nasdaq-tickers", ofType: "json"){
            do {
                let jsonPath = NSData(contentsOf: URL(filePath: path))
                self.json = JSON(jsonPath!)
                for i in 0..<json.indices.count{
                    for _ in json[i]{
                        self.SP500.updateValue( json[i]["Symbol"].stringValue, forKey: json[i]["Company Name"].stringValue)
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
    @State private var test: [String] = []
    @State private var searchAppear = false
    @State private var didSelectStock = false
    let empty: [String] = []
    @State private var searchTicker: String = ""
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(tickerResults, id: \.self) { symbol in
                    Button{
                        self.stockInfo.ticker = self.dataSet.SP500[symbol]
                        print("\(self.dataSet.SP500[symbol])")
                        self.didSelectStock = true
                    }label:{
                        Text("\(symbol)").searchCompletion(symbol)
                    }
                }
            }//.opacity(self.searchAppear ? 0.0 : 1.0)
        }.searchable(text: $searchTicker)
            .sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
                LoadingScreen()
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
            return self.dataSet.SP500.keys.filter{ $0.contains(searchTicker) }
        }
    }
    
    
}
