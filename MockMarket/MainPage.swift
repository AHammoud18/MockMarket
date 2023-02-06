//
//  MainPage.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 1/23/23.
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
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @State var didSelectStock = false
    @State var selectedStock: String?
    let currentDate = DateFormatter()
    let timer = Timer.publish(every: 10.00, on: .main, in: .common).autoconnect()
    let times = ["22-12-27", "23-01-27"]
    
    
    var body: some View{
        GeometryReader { geo in
            let X = geo.frame(in: .global).midX
            let Y = geo.frame(in: .global).midY
            ZStack{
                Button{
                    self.stockInfo.ticker = "AAPL"
                    didSelectStock = true
                }label:{
                    Text("Apple Stock")
                }
                Button{
                    self.stockInfo.ticker = "IBM"
                    didSelectStock = true
                }label:{
                    Text("IBM Stock")
                }.offset(y: -20)
                Divider()
                GroupBox{
                    LineChartView(
                        lineChartController: LineChartController(
                            prices: self.userValue,
                            dates: self.userDates,
                            indicatorPointColor: self.pointPos.indicatorColor,
                            dragGesture: true
                        )
                    )
                }.frame(width: geo.frame(in: .global).maxX/1.2, height: geo.frame(in: .global).maxY/3)
                    .position(x: X, y: Y*1.4)
                    .groupBoxStyle(ChartBox())
            }
            .sheet(isPresented: $didSelectStock, onDismiss: { self.stockInfo.deintitStock() }){
                LoadingScreen()
            }
        }
    }
}


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
    
    func loadStock(){
        self.stockInfo.range = .oneDay
        self.stockInfo.grabStockInfo()
        self.stockInfo.loadTicker()
    }
}

@available(iOS 16.0, *)
struct CompanyStockView: View{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @State private var selectedRange = 0
    @State private var chartRange = 0
    @State private var isSelected = false
    @State private var dateOpacity = false
    @State var dateSelect: [String] = ["1D", "1W", "1M" ,"6M", "1Y", "All"]
    

    var body: some View{
        GeometryReader{ geo in
            let X = geo.frame(in: .local).midX
            let Y = geo.frame(in: .local).midY
            VStack(spacing: 1){
                Text(self.stockInfo.ticker ?? "default")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20))
                    .bold()
                Text(self.stockInfo.stockTicker.last?.displayName ?? "company")
                    .foregroundColor(.black)
                Divider()
                ScrollView(showsIndicators: false){
                    VStack(spacing: 2){
                        Text("\(self.stockInfo.stockTicker.last?.regularMarketPrice ?? 0.0, specifier: "%0.2f" )")
                            .foregroundColor(.black)
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
                                                    .foregroundColor(.gray)
                                                    .overlay{ Text("\(dateSelect[value.self])")
                                                        .foregroundColor(.white)
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
                                        .frame(width: geo.size.width/1.2 ,height: geo.size.height/3.5)
                                        .gesture(DragGesture())
                                }.tag(value.self)
                            }
                            
                        }.tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: geo.size.height/2)
                        Divider()
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width ,height: geo.size.height/2)
                            .overlay(Text("Something Here"))
                        Divider()
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width ,height: geo.size.height/2)
                            .overlay(Text("Something Here"))
                    }
                }
            }
        }
    }
}


@available(iOS 16.0, *)
struct ChartBox: GroupBoxStyle{
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data

    func makeBody(configuration: Configuration) -> some View {
        
        GeometryReader{ geo in
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .shadow(radius: 4, x: 5)
                .shadow(radius: 4, x: 5)
                .overlay(
                    Rectangle()
                        .frame(width: 1, height: geo.size.height)
                        .opacity(self.pointPos.showingIndicator ? 1.0 : 0.0)
                        .position(x: self.pointPos.indicatorPosition.x, y: geo.size.height * 0.5)
                        .foregroundColor(pointPos.indicatorColor)
                        .shadow(color: pointPos.indicatorColor, radius: 2)
                        .clipped()
                )
                
                .overlay(
                    Text("9:30")    
                        .position(x: .zero, y: geo.size.height * 1.05)
                        .font(Font.system(size: 8))
                )
                .overlay(
                    Text("\(self.stockInfo.currentTime)")
                        .position(x: geo.size.width, y: geo.size.height*1.05)
                        .font(Font.system(size: 8))
                )
                
            configuration.label
            configuration.content
        }
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
