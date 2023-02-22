//
//  tabView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct tabView: View {
    @State private var selectedTab = 0
    var body: some View{
        TabView(selection: $selectedTab){
            // fitst view
            ZStack{
                StockPage()
                
            }
            .tabItem({
                Image(systemName: "folder")
                Text("Portfolio")
                })
            .tag(0)
            // second view
            ZStack{
                educationView()
            }
            .tabItem({
                Image(systemName: "books.vertical.fill")
                Text("Lessons")
                })
            .tag(1)
            // third view
            ZStack{
                MarketView()
            }
            .tabItem({
                Image(systemName: "newspaper.fill")
                Text("Mock Market")
                })
            .tag(2)
        }
        
    }
    
    /*
    @State var selectedTab = 1
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab){
                // stock page
                ZStack{
                    StockPage()
                }.onTapGesture {
                        selectedTab = 1
                    }
                .tabItem{
                        Label("Portfolio", systemImage: "folder")
                        //Text("test")
                    }
                .tag(1)

                

                // education page
                ZStack{
                    educationView()
                }.onTapGesture {
                        selectedTab = 2
                    }
                .tabItem {
                        Label("Education", systemImage: "books.vertical.fill")
                        //Text("test2")
                    }
                .tag(2)
                
                // market view
                ZStack{
                    MarketView()
                }.onTapGesture {
                        selectedTab = 3
                }
                .tabItem{
                        Label("Mock Market", systemImage: "newspaper.fill")
                }
                .tag(3)
                
            }
        }
    }*/
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
