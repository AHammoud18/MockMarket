//
//  educationView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct educationView: View {
    @State private var toTutorialBuilding = false
    var body: some View {
        VStack {
            Text("World View")
            Text("Available Levels")
            Spacer()
            HStack{
                Button{
                    toTutorialBuilding = true

                }label:{
                    Text("Tutorial Level")
                }
            }
            Spacer()
        }
        .navigate(to: tutorialBuilding(), when: $toTutorialBuilding)
        
        
        
    }
}


struct educationView_Previews: PreviewProvider {
    static var previews: some View {
        educationView()
    }
}
