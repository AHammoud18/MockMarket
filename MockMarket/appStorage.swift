//
//  appStorage.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/8/23.
//

import Foundation
import SwiftUI

class appStorage: ObservableObject{
    @AppStorage("isTutComplete") var isTutorialComplete = false
    
    // MARK: Tutorial Building
    
    //completed
    @AppStorage("level1Comp") var level1Comp = false
    @AppStorage("level2Comp") var level2Comp = false
    @AppStorage("level3Comp") var level3Comp = false
    @AppStorage("level4Comp") var level4Comp = false
    @AppStorage("level5Comp") var level5Comp = false
    @AppStorage("level6Comp") var level6Comp = false
    
    //unlocked
    @AppStorage("level2Unlocked") var level2Unlocked = false
    @AppStorage("level3Unlocked") var level3Unlocked = false
    @AppStorage("level4Unlocked") var level4Unlocked = false
    @AppStorage("level5Unlocked") var level5Unlocked = false
    @AppStorage("level6Unlocked") var level6Unlocked = false
}
