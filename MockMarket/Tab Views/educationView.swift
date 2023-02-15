//
//  educationView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI


extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}


struct educationView: View {
    @State private var toTutorialBuilding = false
    @StateObject var a = appStorage()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("World View")
            Text("Available Levels")
            Spacer()
            HStack{
                Button{
                    toTutorialBuilding = true
                    if a.fromMap == true{
                        a.fromMap = false
                        dismiss()
                    }else{
                        a.fromMap = false
                    }
                }label:{
                    Text("Tutorial Building")
                }
            }
            Spacer()
        }
        .navigate(to: tutorialBuilding(), when: $toTutorialBuilding)
        .navigate(to: tutorialBuilding(), when: $a.isTutorialComplete.not)
        
        
    }
}


struct educationView_Previews: PreviewProvider {
    static var previews: some View {
        educationView()
    }
}
