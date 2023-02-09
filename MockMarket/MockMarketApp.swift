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
    @AppStorage("isTutComplete") var isTutorialComplete = false
    
    var body: some Scene {
        WindowGroup {
            
            if isTutorialComplete == true{
                tutorialViews()
            }else{
                ContentView()
            }
            
            //ContentView()

            //MarketView()
        }
    }
}
