//
//  MainPage.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 1/23/23.
//
//

import Foundation
import XCAStocksAPI
import SwiftUI
import Charts



@available(iOS 16.0, *)

struct StockPrices: Identifiable {
    let id = UUID()
    let time: Date
    let price: Double
    
    init(day: Date, price: Double) {
        self.time = day
        self.price = price
    }
}

@available(iOS 16.0, *)
struct StockPage: View{
    @State var userValue = [14.50, 12.00, 18.25, 22.50, 8.00, 45.00]
    @State var userDates = ["23-1-11","23-1-13","23-1-14","23-1-16","23-1-20","23-1-22"]
    @State var priceColor = true
    @State var totalWorth = 0
    @State var percentChange = 4.3
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @StateObject var portfolio = Portfolio.data
    @State var userShares: [Int] = []
    @State var userBP: [Double] = []
    @State var userTickers: [String] = []
    @State var collectedResults: [Double] = []
    @State var didSelectStock = false
    @State var selectedStock: String?
    let currentDate = DateFormatter()
    let timer = Timer.publish(every: 10.00, on: .main, in: .common).autoconnect()
    let times = ["22-12-27", "23-01-27"]
    
    
    @State private var isActive = false
    var body: some View{
        //VStack{
            GeometryReader { geo in
                //let X = geo.frame(in: .global).midX
                //let Y = geo.frame(in: .global).midY
                
                
                //MARK: Portfolio Top Graph
                ScrollView {
                    VStack(alignment:.leading){
                        VStack{
                            Text("My Portfolio")
                                .font(.custom("American Typewriter", size: 24).bold())
                                .padding(.leading)
                                .accessibilityLabel("My Portfolio")
                            
                        }
                        
                        .padding(.top)
                        
                        ZStack {
                            portfolioChartView()
                            VStack(alignment: .leading) {
                                Text("$\(self.portfolio.userTotal)")
                                    .font(.custom("American Typewriter", size: 40).bold())
                                    .dynamicTypeSize(.xxxLarge)
                                HStack {
                                    Image(systemName: "triangle.fill")
                                        .foregroundColor(.green)
                                    Text(" %\(percentChange.formatted())")
                                        .foregroundColor(.green)
                                    .font(.system(size: 25))
                                }.dynamicTypeSize(.xxxLarge)
                                
                            }
                            .position(x: geo.frame(in: .local).minX/2, y: geo.frame(in: .local).minY)
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Current Value: \(self.portfolio.userTotal) dollars, up \(percentChange.formatted()) percent")
                                .fixedSize()
                                
                        }
                        
                        ZStack{
                            portfolioSwitcherView()
                        }
                        .frame(height:75)
                        //.fixedSize(horizontal: false, vertical: true)
                        // this is the holdings box that displays shares that the user has purchased
                        VStack{
                            HStack {
                                Text("Current Holdings")
                                    .font(.custom("American Typewriter", size: 24).bold())
                                    .padding(.leading)
                                    .accessibilityLabel("Current Holdings")
                            }
                                GroupBox{
                                    ScrollView(showsIndicators: false){
                                        VStack(spacing: 12){
                                            ForEach(0..<userTickers.count, id: \.self){ value in
                                                Text("\(self.userValue[value])")
                                                Text("\(self.userTickers[value])")
                                                    .offset(x: -135, y: -6)
                                                    .font(.custom("American Typewriter", size: 20).bold())
                                                    .padding(.leading)
                                                    .accessibilityLabel(self.userTickers[value])
                                                    .overlay(
                                                        Text("\(self.userShares[value]) shares")
                                                            .offset(x: -125, y: 12)
                                                            .font(Font.system(size: 14))

                                                    )
                                                Divider()
                                            }
                                        }
                                    }.padding()
                                }.groupBoxStyle(ChartBox())
                                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .global).minY*2)
                                    .frame(width: geo.size.width/1.1, height: geo.size.height/3.2)
                                
                            
                            
                        }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    }
                } // scroll view
                .introspectScrollView(){scroller in
                    scroller.bounces = false
                }
            }
//            .sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
//                LoadingScreen()
//            }
        //}
        // Refresh the user portfolio every 10 seconds
            .onReceive(timer){ _ in
                if self.portfolio.purchasedShare == true{
                    Task{
                        valueCalc()
                    }
                }
                
            }
        
        // Collect the user info from the JSON when this view loads
            .onAppear{
                //self.userData.writeFile()
                if self.portfolio.purchasedShare == true{
                    self.getUserValue()
                }
                
            }
    }
    
    // sorting the collected JSON data into arrays to display
    func getUserValue(){
        var i = 0
        self.userTickers = []
        self.userBP = []
        self.userShares = []
        for (tickers, values) in self.portfolio.userPortfolio{
            self.userTickers.insert(tickers, at: i)
            for (shares, bought_price) in values{
                print("shares: \(shares) bought: \(bought_price)")
                self.userBP.insert(bought_price, at: i)
                self.userShares.insert(shares, at: i)
                //self.userValue = self.stockData.stockTicker.last?.regularMarketPrice Double(shares) * bought_price
                print("User Bought Prices: \(self.userBP)")
                print("User Shares: \(self.userShares)")
                print("User Tickers: \(self.userTickers)")
            }
            i += 1
        }
        valueCalc()
    }
    
    
    // calculate user gain/loss after purhcase of stock
    func valueCalc(){
        self.collectedResults = []
        self.portfolio.userTotal = 0.0
        for i in 0..<self.userTickers.count{
            self.stockInfo.currentPrices!.append(0.0)
            self.stockInfo.loadTickerforUser(ticker: self.userTickers[i])
            print("prices: \(self.stockInfo.currentPrices![i])")
            self.collectedResults.insert((self.stockInfo.currentPrices![i] - self.userBP[i]) * Double(self.userShares[i]), at: i)
        }
        for i in 0..<collectedResults.count{
            self.portfolio.userTotal += collectedResults[i]
        }
    }
}
        


// loading screen while stock info loads in the background, this screen navigates to the stock view when everything
// has been loaded
struct LoadingScreen: View{
    @State var loadedStock = false
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject var stockInfo = StockData.data

    var body: some View{

        ZStack{
            ProgressView("Loading \(self.stockInfo.stockTicker.last?.displayName ?? "Companie")'s Chart...")
                    .progressViewStyle(.circular)
                    .padding()
                    .onReceive(timer){ _ in
                        if progress <= 4 && loadedStock == false{
                            progress += 4
                        }
                        else if progress >= 5{
                            loadedStock = true
                        }
                        else{
                            loadedStock = true
                        }
                    }
            }
            .onAppear{
                if loadedStock == false{
                    loadStock()
                }
        }.navigate(to: CompanyStockView(), when: $loadedStock)
        
    }
    // run this function when the loading screen appears
    func loadStock(){
        self.stockInfo.range = .oneDay
        self.stockInfo.grabStockInfo()
        self.stockInfo.loadTicker()
    }
}


// the stock view that shows after everything has loaded
@available(iOS 16.0, *)
struct CompanyStockView: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @StateObject var userData = Portfolio.data
    @State private var selectedRange = 0
    @State private var chartRange = 0
    @State private var isSelected = false
    @State private var dateOpacity = false
    @State var dateSelect: [String] = ["1D", "1W", "1M" ,"6M", "1Y", "All"]
    @State var showPurchasePage = false
    @State var shares: Int = 0
    // formatter for a number pad
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        GeometryReader{ geo in
            let X = geo.frame(in: .local).midX
            let Y = geo.frame(in: .local).midY
            VStack(spacing: 1){
                Text(self.stockInfo.ticker ?? "default")
                    .foregroundColor(.appColorBlack)
                    .font(Font.system(size: 20))
                    .bold()
                Text((self.stockInfo.stockTicker.last?.displayName ?? "company"))
                    .foregroundColor(.appColorBlack)
                Divider()
                ScrollView(showsIndicators: false){
                    VStack(spacing: 2){
                        Text("\(self.stockInfo.stockTicker.last?.regularMarketPrice ?? 0.0, specifier: "%0.2f" )")
                            .foregroundColor(.appColorBlack)
                            .bold()
                            .offset(y: 5)
                        Text("")
                        Rectangle()
                            .frame(height: 40)
                            .foregroundColor(.clear)
                        Divider()
                        Divider()
                            .foregroundColor(.clear)
                            .frame(height: 1)
                            .padding(EdgeInsets(top: 80, leading: 20, bottom: 0, trailing: 20))
                            .overlay(
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(alignment: .center, spacing: 2){
                                        ForEach(0..<6){ value in
                                            Button{
                                                chartRange = value.self
                                                isSelected = true
                                            }label:{
                                                RoundedRectangle(cornerRadius: 8)
                                                    .foregroundColor(.appColorBlack)
                                                    .overlay{ Text("\(dateSelect[value.self])")
                                                        .foregroundColor(.appColorWhite)
                                                        .bold()
                                                    }
                                                
                                            }.frame(width: 40,height: 40)
                                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                                                .tag(value.self)
                                        }
                                    }
                                }

                            )
                        TabView(selection: $chartRange){
                            ForEach(0..<6){ value in
                                ZStack{
                                    Chart(range: value.self)
                                        .frame(width: X/1.2 ,height: Y/3.5)
                                        .gesture(DragGesture())
                                }.tag(value.self)
                            }
                            
                        }.tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: geo.size.height/2)
                        Divider()
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width ,height: geo.size.height/2)
                            .overlay(
                                HStack{
                                    Button{
                                        showPurchasePage.toggle()
                                    }label: {
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(.accentColor)
                                            .frame(width: 100, height: 40)
                                            .overlay(
                                                Text("Buy")
                                                    .foregroundColor(.white)
                                                    .bold()
                                            )
                                        
                                    }
                                    Button{
                                        showPurchasePage.toggle()
                                    }label:{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(.pink)
                                            .frame(width: 100, height: 40)
                                            .overlay(
                                                Text("Sell")
                                                    .bold()
                                                    .foregroundColor(.white)
                                            )
                                    }
                                }
                                
                            )
                        Divider()
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width ,height: geo.size.height/2)
                            .overlay(Text("Something Here"))
                    }
                } // Scroll View
            } // Vstack
            .sheet(isPresented: $showPurchasePage){
                purchasePage
            }// PurchasePage View
        } // Geo Reader
    } // Body View
    
    
    // display the purhcase page when the user buys/sells their stock
    var purchasePage : some View{
        GeometryReader{ geo in
            let X = geo.frame(in: .global).midX
            let Y = geo.frame(in: .global).midY
            
            ZStack{
                Text("\(self.userData.mockCurrency, specifier: "%0.2f")").position(x: X, y: Y*0.2)
                Text("Purchase Price: $\(self.stockInfo.stockTicker.last?.regularMarketPrice ?? 0.0, specifier: "%0.2f" )").position(x: X, y: Y*0.8)
                Text("How Many Shares Would You Like To Purchase?").position(x: X, y: Y*0.9)
                TextField("Shares", value: $shares, formatter: formatter)
                    .keyboardType(.numberPad)
                    .position(x: X, y: Y)
                    .padding(EdgeInsets(top: 0, leading: 80, bottom: 0, trailing: 100))
                Button{
                    if (self.userData.mockCurrency - (Double(self.shares) * (self.stockInfo.stockTicker.last?.regularMarketPrice)!) > 0){
                        self.userData.appendData(ticker: self.stockInfo.ticker!, shares: self.shares, boughtPrice: (self.stockInfo.stockTicker.last?.regularMarketPrice)!)
                        self.userData.writeFile()
                        self.userData.loadFile()
                    }else{
                        print("not enough money!")
                    }
                }label:{
                    RoundedRectangle(cornerRadius: 8)
                        .opacity($shares.wrappedValue > 0 ? 1.0 : 0.5)
                        .foregroundColor(.pink)
                        .frame(width: 100, height: 40)
                        .overlay(
                            Text("Confirm Order")
                                .bold()
                                .foregroundColor(.white)
                    )
                }.position(x: X, y: Y*1.2)
                    .disabled($shares.wrappedValue > 0 ? false : true)
            }
        }
    }
} // Struct View



// the style of the box
@available(iOS 16.0, *)
struct ChartBox: GroupBoxStyle{
        @StateObject var stockInfo = StockData.data
        @StateObject var pointPos = indicatorPos.data
        
        func makeBody(configuration: Configuration) -> some View {
            
            GeometryReader{ geo in
                let width = geo.size.width
                let height = geo.size.height
                
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.appColorWhite)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.appColorWhite))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: width * 1.02, height: height * 1.02)
                                    .offset(x: 8, y: 8)
                                    .foregroundColor(.appColorBlack)
                            )
                            .frame(width: width, height: height)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(style: StrokeStyle(lineWidth: 4))
                                    .foregroundColor(.appColorBlack)
                                    
                            )
                            .overlay(
                                Rectangle()
                                    .frame(width: 1, height: height * 2)
                                    .opacity(self.pointPos.showingIndicator ? 1.0 : 0.0)
                                    .position(x: self.pointPos.indicatorPosition.x, y: height)
                                    .foregroundColor(pointPos.indicatorColor)
                                    .shadow(color: pointPos.indicatorColor, radius: 2)
                                    .clipped()
                            )
                        //                .overlay(
                        //                    Text("9:30")
                        //                        .position(x: .zero, y: geo.size.height * 1.05)
                        //                        .font(Font.system(size: 8))
                        //                )
                            .overlay(
                                Text("\(self.stockInfo.currentTime)")
                                    .position(x: width, y: height * 1.05)
                                    .font(Font.system(size: 8))
                            )
                
                    //.padding(EdgeInsets(top:-50, leading: -3, bottom: -5, trailing: -3))
                
                
                configuration.label
                configuration.content
                    
            }
        }
    }

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        StockPage()
    }
}


/*
 
 
 .overlay(
     RoundedRectangle(cornerRadius: 8)
         .frame(width: 40, height: 20)
         .position(x: geo.size.width*1.06 ,y: self.pointPos.latestPrice)
     // flip 180 degrees, chart does this for the line path
         .rotationEffect(.degrees(180), anchor: .center)
         .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
         .overlay(
             Text(String(self.stockInfo.stockPrice[self.pointPos.selectedRange].last!))
         )
 )
 
 
 GroupBox{
     LineChartView(
         lineChartController: LineChartController(
             prices: self.stockInfo.stockPrice,
             dates: self.stockInfo.stockDates,
             dragGesture: true
         ))
 }.frame(width: geo.frame(in: .global).maxX/1.2, height: geo.frame(in: .global).maxY/3)
     .position(x: X, y: Y)
     .groupBoxStyle(chartBoxStyle())
 */
