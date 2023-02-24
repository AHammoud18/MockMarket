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
    @Published var searchTicker: String = ""

    
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
    @StateObject var dataSet = tickerDocument.data
    @StateObject var userData = Portfolio.data
    @State private var test: [String] = []
    @State private var searchAppear = false
    @State private var tempTicker: String = ""
    @State private var tempShares: Int = 0
    @State private var tempBoughtPrice: Double = 0.0
    
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        GeometryReader{ geo in
                ZStack{
                    NavigationView{
                        searchQuery()
                    }
                    .searchable(text: $dataSet.searchTicker, prompt: "Search Mock Market...")
                    /*GeometryReader{ geo in
                     VStack{
                     GroupBox{
                     Text("Hi")
                     }.groupBoxStyle(ChartBox())
                     .position(x: geo.size.width/2, y: geo.size.height/2)
                     .frame(width: geo.size.width/4, height: geo.size.height/8)
                     }
                     }*/
                }
                
        }
    }
    
    
}

struct searchQuery: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @StateObject var dataSet = tickerDocument.data
    @State private var dailyMovers = ["AAPL", "TSLA", "NVDA" ,"SPX"]
    @State private var didSelectStock = false
    @State private var categorySel = 0
    @State private var categorySymbols = ["star.fill", "newspaper", "chart.pie.fill", "arrow.up.forward.app"]
    @State private var categoryLabels = ["Top 100", "IPOs", "ETFs", "Popular"]
    let empty: [String] = []
    @Environment(\.isSearching) private var isSearching
    var body: some View{
        VStack{
            GeometryReader{ geo in
                ScrollView(showsIndicators: false) {
                    let screen = geo.frame(in: .local)
                    // MARK: | Categories |
                    HStack(spacing: 0){
                        ForEach(0..<4){ value in
                            GroupBox{
                                Button{
                                    self.categorySel = value
                                    print(self.categorySel)
                                }label:{
                                    Image(systemName: categorySymbols[value])
                                        .renderingMode(.template)
                                        .resizable()
                                        .position(x: screen.midX*0.17, y: screen.midY*0.1)
                                }.frame(width: 40, height: 40)
                            }.groupBoxStyle(ChartBox())
                                .frame(width: geo.size.width/6, height: geo.size.height/10)
                            
                                .position(x: screen.midX*0.25, y:
                                            screen.midY*0.2)
                                .overlay(
                                    Text(categoryLabels[value])
                                        .position(x: screen.midX*0.23, y: screen.midY*0.4)
                                        .frame(width: 100)
                                        .font(.custom("American Typewriter", size: 18).bold())
                                        .padding(.leading)
                                        .accessibilityLabel(categoryLabels[value])
                                )
                            
                            
                        }
                        
                        
                    }// category stack
                    .opacity(isSearching ? 0.0 : 1.0)
                    // MARK: | Daily Movers |
                    ZStack{
                        Text("Daily Movers")
                            .font(.custom("American Typewriter", size: 28).bold())
                            .padding(.leading)
                            .position(x: screen.width/4, y: screen.midY*0.2)
                        ScrollView(.horizontal, showsIndicators: false){
                            GeometryReader{ geo in
                                let screen = geo.frame(in: .local)
                                LazyHStack(spacing: 0){
                                    ForEach(0..<dailyMovers.count){ value in
                                        GroupBox{
                                            Button{
                                                
                                            }label:{
                                                VStack{
                                                    // ticker symbol
                                                    Text(dailyMovers[value])
                                                        .font(.custom("American Typewriter", size: 18).bold())
                                                        .padding(.leading)
                                                    // current price
                                                    Text("194.56")
                                                        .font(.custom("American Typewriter", size: 18).bold())
                                                        .padding(.leading)
                                                    // percent change
                                                    Text("(4.35%)")
                                                        .font(.custom("American Typewriter", size: 18).bold())
                                                        .padding(.leading)
                                                        .onAppear{
                                                            
                                                        }
                                                    

                                                }.position(x: screen.width*4, y: screen.height/4.5)
                                            }
                                        }.groupBoxStyle(ChartBox())
                                            .frame(width: screen.width*10, height: screen.height*0.4)
                                            .position(x: screen.midX * 5 * CGFloat(value), y: screen.midY*1)
                                            
                                    }
                                    
                                }.padding(.leading, 70)
                                //.position(x: screen.midX, y: screen.midY*1.25)
                            }
                        }.frame(width: screen.width, height: screen.height/2)
                    }.position(x: screen.midX, y: screen.midY*0.6)
                    
                    // MARK: | Market News |
                    VStack(spacing: 20){
                        Text("Market News")
                            .font(.custom("American Typewriter", size: 28).bold())
                            .padding(.leading)
                        ScrollView(showsIndicators: false){
                            VStack(){
                                ForEach(0..<4){ value in
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: screen.width/1.1, height: screen.height/6)
                                        
                                }.padding(.bottom, 10)
                            }.padding(.leading, 100)
                        }.padding(.trailing, -100)
                    }.position(x: screen.midX*0.5, y: screen.midY*0.7)
                    
                }.frame(width: geo.size.width, height: geo.size.height)
            } // geo reader
        }.opacity(isSearching ? 0.0 : 1.0)
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
        }.sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
            LoadingScreen()
         }
        .onAppear{
            self.dataSet.loadFile()
        }
    }
    
    func loadStock(){
        self.stockInfo.range = .oneDay
        self.stockInfo.grabStockInfo()
        self.stockInfo.loadTicker()
    }
    
    var tickerResults: [String]{
        
        if self.dataSet.searchTicker.isEmpty{
            return empty
        }
        else{
            return self.dataSet.Nasdaq.keys.filter{ $0.contains(self.dataSet.searchTicker) }
        }
    }
}


@available(iOS 16.0, *)
struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
