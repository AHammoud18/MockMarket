//
//  PortfolioData.swift
//  MockMarket
//
//  Created by Ali Hamoud on 2/9/23.
//

import Foundation
import SwiftyJSON



class Portfolio: ObservableObject{
    @Published var userData: [String : [Int : Double]] = [:]
    let appPath = Bundle.main.resourceURL
    
    func loadFile(){

        //logic to read JSON file
        
    }
    
    @MainActor func writeFile(){
        
        userData["AAPL"] = [12 : 141.22]

        let file = JSON(userData)
        print(file)
    }
    
  
    
    
    
}
