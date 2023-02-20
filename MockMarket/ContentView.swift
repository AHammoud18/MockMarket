//
//  ContentView.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 1/20/23.
//

import SwiftUI
import XCAStocksAPI
//

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension Color{
    static let appColorWhite = Color("appColorWhite")
    static let appColorBlack = Color("appColorBlack")
}



@available(iOS 16.0, *)
struct ContentView: View {
    @StateObject private var tutorial = appStorage()
    @StateObject var stockData = StockData.data
    @StateObject var portfolio = Portfolio.data
    @State private var progress: Double = 0.0
    @State var letLoadAndTutIsComplete = false
    @State var letLoadButTutIsntComplete = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // create a loading screen so that Yahoo Finance can send up the updated info
    var body: some View {
        ZStack {
            GroupBox{
                ProgressView("Loading Data")
                    .multilineTextAlignment(.center)
                    .progressViewStyle(.circular)
                    .padding()
                    .onReceive(timer){ _ in
                        if progress <= 4{
                            progress += 4
                        }
                        else if progress >= 5{
                            if tutorial.isTutorialComplete == false{
                                letLoadButTutIsntComplete = true
                            }else{
                                letLoadAndTutIsComplete = true
                            }
                            
                        }
                    }
            }
        }.onAppear{
            self.portfolio.checkFile()
            //stockData.loadStock()
            //stockData.loadTicker()
            
        }
        .navigate(to: tabView(), when: $letLoadAndTutIsComplete)
        .navigate(to: tutorialViews(), when: $letLoadButTutIsntComplete)
    }
}


struct rectangleBackground: View{
    var width: CGFloat
    var height: CGFloat
    var radiusOfCorners: CGFloat
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: radiusOfCorners)
                .foregroundColor(.appColorWhite)
                .background(RoundedRectangle(cornerRadius: radiusOfCorners).foregroundColor(.appColorWhite))
                .background(
                    RoundedRectangle(cornerRadius: radiusOfCorners)
                        .foregroundColor(.appColorBlack)
                        .frame(width: width * 1.02, height: height * 1.02)
                        .offset(x: 8, y: 8)
                )
                .frame(width: width, height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: radiusOfCorners)
                        .stroke(style: StrokeStyle(lineWidth: 4))
                        .foregroundColor(.appColorBlack)
                        
                )
            
        }
    }
}


@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
