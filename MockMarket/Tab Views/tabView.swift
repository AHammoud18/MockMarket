//
//  tabView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct tabView: View {
    var body: some View {
        VStack {
            TabView{
                StockPage()
                    .tabItem{
                        Label("Portfolio", systemImage: "folder")
                        //Text("test")
                    }


                educationView()
                    .tabItem {
                        Label("Education", systemImage: "books.vertical.fill")
                        //Text("test2")
                    }
                
                marketNewsView()
                    .tabItem{
                        Label("Mock Market", systemImage: "newspaper.fill")
                    }
                
            }
        }
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
