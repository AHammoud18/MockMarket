//
//  portfolioDateSwitcherView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct portfolioDateSwitcherView: View {
    
    
    var body: some View {
        GeometryReader{ geo in
            let switcherWidth = geo.size.width/1.09
            let switcherHeight = geo.size.height
            
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.appColorWhite)
                    .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.appColorWhite))
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .foregroundColor(.appColorBlack)
                            .frame(width: switcherWidth * 1.02, height: switcherHeight * 1.02)
                            .offset(x: 8, y: 8)
                    )
                    .frame(width: switcherWidth, height: switcherHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(style: StrokeStyle(lineWidth: 4))
                            .foregroundColor(.appColorBlack)
                            
                    )
                
            }.frame(width: geo.frame(in: .global).midX * 2)
        }
    }
}
