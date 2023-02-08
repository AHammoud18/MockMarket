//
//  SwiftyPythonApp.swift
//  SwiftyPython
//
//  Created by Ali Hamoud on 1/20/23.
//
//
import SwiftUI

@available(iOS 16.0, *)
@main
struct MockMarket: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            //MarketView()
        }
    }
}
