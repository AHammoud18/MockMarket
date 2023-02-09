//
//  tutorialViews.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/8/23.
//

import SwiftUI

struct tutorialViews: View {
    @State var test = false
    @StateObject private var tutorial = appStorage()
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("\(test.description)")
            Text("\(tutorial.isTutorialComplete.description)")
            HStack{
                Button{
                    test = true
                    tutorial.isTutorialComplete = true
                }label:{
                    Text("Tutorial Complete")
                        .foregroundColor(.green)
                }
                
                Button{
                    test = false
                    tutorial.isTutorialComplete = false
                }label:{
                    Text("Tutorial not complete")
                        .foregroundColor(.red)
                }
            }
        }.onAppear{
            
        }.navigate(to: StockPage(), when: $tutorial.isTutorialComplete)
    }
}

struct tutorialViews_Previews: PreviewProvider {
    static var previews: some View {
        tutorialViews()
    }
}
