//
//  tabView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct tabView: View {
    @State var selectedTab = 1
    var body: some View {
        VStack {
            TabView(selection: $selectedTab){
                StockPage()
                    .onTapGesture {
                        selectedTab = 1
                    }
                    .tabItem{
                        Label("Portfolio", systemImage: "folder")
                        //Text("test")
                    }.tag(1)


                educationView()
                    .onTapGesture {
                        selectedTab = 2
                    }
                    .tabItem {
                        Label("Education", systemImage: "books.vertical.fill")
                        //Text("test2")
                    }.tag(2)
                
                marketNewsView()
                    .onTapGesture {
                        selectedTab = 3
                    }
                    .tabItem{
                        Label("Mock Market", systemImage: "newspaper.fill")
                    }.tag(3)
                
            }
        }
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
