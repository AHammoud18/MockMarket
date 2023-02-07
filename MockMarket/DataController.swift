//
//  DataController.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/7/23.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataModel")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}


