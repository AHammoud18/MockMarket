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
}
