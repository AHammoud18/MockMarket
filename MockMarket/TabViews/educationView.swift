//
//  educationView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI
import Introspect

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
    @State private var nextLevel = false
    @State private var isCompleted = false
    @State private var currentLevel = 0
    @State private var maxID = 3
    @State private var UnitTitles = ["Test", "Reading Charts", "Trading", "Company Trends", ""]
    @State private var UnitRewards = ["0", "2000", "1700", "2300", ""]
    @StateObject var a = appStorage()
    @Environment(\.dismiss) var dismiss
    
    var header: some View{
        GeometryReader{ geo in
            let X = geo.frame(in: .local)
            let Y = geo.frame(in: .local)
            // app header
            Rectangle()
                .foregroundColor(.cyan)
                .frame(width: geo.size.width, height: geo.size.height*0.2)
                .position(x: X.midX, y: Y.minY)
        }
    }

    
    var levelBox: some View{
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.appColorBlack)
            .padding(.horizontal, 25)
    }
    
    var star: some View{
        ZStack{
            Image("star")
                .resizable()
                .renderingMode(.template)
                .frame(width: 40,height: 40)
            Image("starFill")
                .resizable()
                .renderingMode(.template)
                .frame(width: 40,height: 40)
                .opacity(isCompleted ? 1.0 : 0.0)
        }
    }

    
    var body: some View {
        GeometryReader{ geo in
            let X = geo.frame(in: .local)
            let Y = geo.frame(in: .local)
            ScrollViewReader{ scroller in
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .center){
                        // The first level presented
                        levelBox
                            .position(x: X.midX, y: Y.midY*0.5)
                            .frame(width: geo.size.width/1.4, height: geo.size.height/2)
                            .opacity(currentLevel == 0 ? 1.0 : 0.0)
                            .scaleEffect(
                                withAnimation(.easeInOut(duration: 1)){
                                    currentLevel == 0 ? 1.0 : 0.8
                                }
                            )
                            .shadow(radius: 10)
                            .shadow(radius: 10)
                            .shadow(radius: 10)
                            .id(0)
                            .overlay(
                                Text("Unit 1")
                                    .font(.custom("American Typewriter", fixedSize: 30))
                                    .bold()
                                    .foregroundColor(Color.appColorBlack)
                                    .position(x: X.midX ,y: Y.minY)
                                    .offset(y: -20)
                                    .scaleEffect(
                                        withAnimation(.easeInOut(duration: 1)){
                                            currentLevel == 0 ? 1.0 : 0.8
                                        }
                                    )
                            )
                            .overlay(
                                ZStack{
                                    
                                    // below is an image placeholder
                                    Button{print("clicked")}label:{}.frame(width: geo.size.width/1.7, height: geo.size.height/4)
                                    RoundedRectangle(cornerRadius: 16).frame(width: geo.size.width/1.7,height: geo.size.height/4.5)
                                        .foregroundColor(Color.appColorWhite)
                                        .offset(y: -125)
                                        .opacity(1.0)
                                    Image("Unit1IMG")
                                        .resizable()
                                        .frame(width: geo.size.width/1.7,height: geo.size.height/4.5)
                                        .offset(y: -125)
                                    star
                                        .foregroundColor(Color.appColorWhite)
                                    Text("The Market")
                                        .font(.custom("American Typewriter", fixedSize: 20))
                                        .bold()
                                        .foregroundColor(Color.appColorWhite)
                                        .offset(y: 40)
                                    Image("CurrencySymbol")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .offset(x: -25,y: 85)
                                    Text("1500")
                                        .foregroundColor(.white)
                                        .bold()
                                        .offset(x: 25,y: 85)
                                    Image("MysteryShare")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .offset(y: 150)
                                    
                                }.position(x: X.midX, y: Y.midY*0.5)
                                    .scaleEffect(
                                        withAnimation(.easeInOut(duration: 1)){
                                            currentLevel == 0 ? 1.0 : 0.8
                                        }
                                    )
                            )
                            //.opacity(0.0)
                        ForEach(1..<5){ value in
                            Text("Unit \(value.self+1)")
                                .font(.custom("American Typewriter", fixedSize: 30))
                                .bold()
                                .foregroundColor(Color.appColorBlack)
                                .position(x: geo.size.width/1.6 ,y: Y.midY*0.45)
                                .scaleEffect(
                                    withAnimation(.easeInOut(duration: 1)){
                                        currentLevel == value.self ? 1.0 : 0.8
                                    }
                                )
                            levelBox
                                .frame(width: geo.size.width/1.4, height: geo.size.height/2)
                                .id(value)
                                .opacity(currentLevel == value.self ? 1.0 : 0.0)
                                .scaleEffect(
                                    withAnimation(.easeInOut(duration: 1)){
                                        currentLevel == value.self ? 1.0 : 0.8
                                    }
                                )
                                .shadow(radius: 10)
                                .shadow(radius: 10)
                                .shadow(radius: 10)
                                .overlay(
                                    ZStack{
                                        
                                        // below is an image placeholder
                                        RoundedRectangle(cornerRadius: 16).frame(width: geo.size.width/1.7,height: geo.size.height/4.5)
                                            .foregroundColor(Color.appColorWhite)
                                            .offset(y: -125)
                                        star
                                            .foregroundColor(Color.appColorWhite)
                                        Text(UnitTitles[value.self])
                                            .font(.custom("American Typewriter", fixedSize: 20))
                                            .bold()
                                            .foregroundColor(Color.appColorWhite)
                                            .offset(y: 40)
                                        Image("CurrencySymbol")
                                            .resizable()
                                            .renderingMode(.template)
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                            .offset(x: -25,y: 85)
                                        Text(UnitRewards[value.self])
                                            .foregroundColor(.white)
                                            .bold()
                                            .offset(x: 25,y: 85)
                                        Image("MysteryShare")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .offset(y: 150)
                                        
                                    }.scaleEffect(
                                        withAnimation(.easeInOut(duration: 1)){
                                            currentLevel == value.self ? 1.0 : 0.8
                                        }
                                    )
                                ) // overlay closure
                                
                        }
                    }.onChange(of: currentLevel){ _ in
                        withAnimation(.easeInOut(duration: 0.5)){
                            scroller.scrollTo(currentLevel, anchor: .center)
                            
                        }
                    }
                    .background(
                        Image("gridPaper")
                        .resizable()
                        .frame(width: geo.size.width*7 ,height: geo.size.height)
                        .blur(radius: 1)
                    )
                }//Scroll View
                .introspectScrollView{ scroller in
                    //scroller.center.x = X.minX
                    scroller.contentOffset.x = X.minX
                }
                .gesture(
                    DragGesture()
                        .onEnded(){ value in
                            if value.predictedEndLocation.x > X.midX{
                                withAnimation(.easeInOut(duration: 0.5)){
                                    currentLevel = max(currentLevel-1, 0) // return number greater than -1
                                }
                                print(currentLevel)

                            }
                            if value.predictedEndLocation.x < X.midX{
                                withAnimation(.easeInOut(duration: 0.5)){
                                    currentLevel = min(currentLevel+1, (maxID)) // return number smaller than max id
                                }
                                print(currentLevel)

                            }
                        }
                )// gesture
                
            } // scroll view reader
            .scrollDisabled(true)
            .position(x: X.midX, y: Y.midY*1.1)
            .overlay(
                header
            )
        }.ignoresSafeArea()
            .background(Color.appColorWhite)
        /*
        .navigate(to: tutorialBuilding(), when: $toTutorialBuilding)
        .navigate(to: tutorialBuilding(), when: $a.isTutorialComplete.not)*/
        
        
    }
}


struct educationView_Previews: PreviewProvider {
    static var previews: some View {
        educationView()
    }
}
