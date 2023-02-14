//
//  PortfolioData.swift
//  MockMarket
//
//  Created by Ali Hamoud on 2/9/23.
//

import Foundation
import SwiftyJSON
import SwiftUI
import System


class Portfolio: ObservableObject{
    static let data = Portfolio()
    private var json: JSON = []
    private var jsonIndicides: Int?
    @StateObject var stockData = StockData()
    @AppStorage ("file_check") var fileExist: Bool?
    //@Published var userData: [String : [Int : Double]] = [:]
    @Published var userData: [JSON]?
    @Published var userPortfolio: [String : [Int : Double]] = [:]
    let perms = FilePermissions(rawValue: 0o644)
    //var appPath = Bundle.main.resourceURL
    func appDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
    }
    
    func checkFile(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let fileManager = FileManager.default
        if let file = url.appendingPathComponent("TestData.json"){
            let filePath = file.path
            if fileManager.fileExists(atPath: filePath){
                loadFile()
            }else{
                print("No file! Creating One...")
                emptyFile()
                loadFile()
            }
        }
        

    }
    // function to load file within app's directory
    // this should only happen once
    func loadFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        let data = JSON(NSData(contentsOf: path))
        userData = [data]
        for i in 0..<userData![0].count{
            //print(userData[0][i+1]["ticker"])
            userPortfolio.updateValue([userData![0][i+1]["shares"].intValue : userData![0][i+1]["bought_price"].doubleValue], forKey: userData![0][i+1]["ticker"].stringValue)
        }
        //return [data]
    }
    
    // new stock purchases will be added here
    @MainActor func appendData(ticker: String, shares: Int, boughtPrice: Double){
        let frame = jsonFrame(ticker: ticker, shares: shares, boughtPrice: boughtPrice)
        let data = JSON(frame.createFrame())
        userData!.append(data)
    }
    
    @MainActor func removeData(){
        // logic here to remove a share
    }
    
    // write data to json file
    @MainActor func writeFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        do{
            let data = "\(userData!.map{$0})"
            print(data)
            try data.write(to: path, atomically: true, encoding: .utf8)
            print("successfully written to \(path)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // delete all user data
    @MainActor func emptyFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        do{
            userData = [JSON()]
            //let data = "\(userData![0].map{$0})"
            let data = ""
            try data.write(to: path, atomically: true, encoding: .utf8)
            print("successfully emptied file at \(path)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // display json for bug testing
    @MainActor func displayFile(){
        print(userData!)
        print(userPortfolio)
    }
  
    
}

struct jsonFrame{
    var ticker: String
    var shares: Int
    var boughtPrice: Double
    
    init(ticker: String, shares: Int, boughtPrice: Double){
        self.ticker = ticker
        self.shares = shares
        self.boughtPrice = boughtPrice
    }
    
    func createFrame() -> String{
        return #"{"ticker" : "\#(self.ticker)", "shares" : "\#(self.shares)" , "bought_price" : "\#(self.boughtPrice)"}"#

    }
    
      
}
