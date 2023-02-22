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
    private var jsonIndicides: Int = 0
    @StateObject var stockData = StockData()
    @AppStorage ("did_purchase") var purchasedShare = false
    @AppStorage ("file_check") var fileExist: Bool?
    @AppStorage ("deleteEmpty") var emptyJSON: Bool = true
    @AppStorage ("currency") var mockCurrency = 20000.00
    @AppStorage ("user_value") var userTotal = 0.0
    @AppStorage ("key_duplicate") var keyDupe = 0
    //@Published var userData: [String : [Int : Double]] = [:]
    @Published var userData = [JSON()]
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
                createFile()
                loadFile()
            }
        }
        

    }
    // function to load file within app's directory
    // this should only happen once
    func loadFile(){
        self.userData = [JSON()]
        let path = appDirectory().appendingPathComponent("TestData.json")
        let data = JSON(NSData(contentsOf: path))
        for i in 0..<data.count{
            if !data[i].isEmpty{
                print("empty json at: \(i)")
                self.userData.insert(data[i], at: i)
            }
        }
        for i in 0..<self.userData.count-1{
            //print(userData[0][i+1]["ticker"])
            self.userPortfolio.updateValue([userData[i]["shares"].intValue : userData[i]["bought_price"].doubleValue], forKey: userData[i]["ticker"].stringValue)
            self.jsonIndicides += 1
        }
        print(userData)
        //return [data]
    }
    
    // new stock purchases will be added here
    @MainActor func appendData(ticker: String, shares: Int, boughtPrice: Double){
        self.mockCurrency -= (Double(shares) * boughtPrice)
        if userPortfolio.keys.contains(ticker){
            let frame = jsonFrame(ticker: "\(ticker) \(self.keyDupe)", shares: shares, boughtPrice: boughtPrice)
            self.keyDupe += 1
            let data = JSON(frame.createFrame())
            self.userData.insert(data, at: self.jsonIndicides)
            print(data)
        }else{
            let frame = jsonFrame(ticker: ticker, shares: shares, boughtPrice: boughtPrice)
            let data = JSON(frame.createFrame())
            self.userData.insert(data, at: self.jsonIndicides)
            print(data)
        }
        let lastIndex = self.userData.endIndex
        self.purchasedShare = true
        if self.emptyJSON == true{
            print("removed")
            self.userData.remove(at: lastIndex-1)
            self.emptyJSON = false
        }

    }
    
    @MainActor func removeData(){
        // logic here to remove a share
    }
    
    // write data to json file
    @MainActor func writeFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        do{
            //try FileManager.default.removeItem(at: path)
            let data = "\(userData.map{$0})"
            try data.write(to: path, atomically: true, encoding: .utf8)
            print("successfully written to \(path)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // create an empty json
    @MainActor func createFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        do{
            //let data = "\(userData![0].map{$0})"
            let data = ""
            try data.write(to: path, atomically: true, encoding: .utf8)
            print("successfully emptied file at \(path)")
        }catch{
            print(error.localizedDescription)
        }
    }

    
    // delete all user data
    @MainActor func deleteFile(){
        let path = appDirectory().appendingPathComponent("TestData.json")
        do{
            try FileManager.default.removeItem(at: path)
            self.jsonIndicides = 0
            //let data = "\(userData![0].map{$0})"
            /*let data = ""
            try data.write(to: path, atomically: true, encoding: .utf8)*/
            print("successfully emptied file at \(path)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // display json for bug testing
    func displayFile(){
        print(userData)
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
