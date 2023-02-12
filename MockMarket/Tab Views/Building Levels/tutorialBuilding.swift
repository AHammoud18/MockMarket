//
//  tutorialBuilding.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct tutorialBuilding: View{
    @State private var toWorldMap = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        
        GeometryReader{ geo in
            ZStack {
                ZStack{
                    Button{
                        toWorldMap = true
                    }label:{
                        Image(systemName: "map.circle")
                            .font(.system(size: 50))
                            .accessibilityLabel("City Map")
                    }.position(x: geo.frame(in: .global).maxX - 60, y: geo.frame(in: .global).minY)
                        
                    ZStack {
                        Image("tutorialBuilding")
                            .resizable()
                        .frame(width:350, height: 500)
                    }.fixedSize()
                }.background{
                    if colorScheme == .light{
                        Color(.green)
                    }else{
                        Color(.blue)
                    }
                }
            }
            .navigate(to: educationView(), when: $toWorldMap)
        }
    }
}

struct tutorialLevel1: View{
    var body: some View{
        Text("level1")
    }
}

struct tutorialPreviews: PreviewProvider{
    static var previews: some View{
        tutorialBuilding()
    }
    
    
}
