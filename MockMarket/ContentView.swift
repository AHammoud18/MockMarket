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

@available(iOS 16.0, *)
struct ContentView: View {
    @StateObject private var tutorial = appStorage()
    @StateObject var stockData = StockData.data
    @State private var progress: Double = 0.0
    @State var letLoadAndTutIsComplete = false
    @State var letLoadButTutIsntComplete = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // create a loading screen so that Yahoo Finance can send up the updated info
    var body: some View {
        ZStack {
            GroupBox{
                ProgressView("Loading Stocks...")
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
            //stockData.loadStock()
            //stockData.loadTicker()
            
        }
        .navigate(to: StockPage(), when: $letLoadAndTutIsComplete)
        .navigate(to: tutorialViews(), when: $letLoadButTutIsntComplete)
    }
}


@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
