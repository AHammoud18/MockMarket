//
//  tutorialViews.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/8/23.
//

import SwiftUI

struct tutorialViews: View {
    @State var navTut2 = false
    @StateObject private var tutorial = appStorage()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 150, height: 100)
                        .offset(x: 20)
                    Text("Welcome to")
                        .font(.custom("American Typewriter", fixedSize: 40))
                        .foregroundColor(.appColorBlack)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 10)
                    Text("Mock Market")
                        .font(.custom("American Typewriter", fixedSize: 50).bold())
                        .foregroundColor(.appColorBlack)
                    
                    Button{
                        navTut2 = true
                    }label:{
                        Text("Let's jump in")
                            .font(.custom("American Typewriter", fixedSize: 20))
                            .foregroundColor(.appColorBlack)
                            .background{
                                rectangleBackground(width: 200, height: 50, radiusOfCorners: 10)
                            }
                    }.padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                }.position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                    
                
                
                
                
                Image("dashedLines")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .position(x: geo.frame(in: .global).maxX/1.15, y: geo.frame(in: .global).minY/50)
                    
            }.navigate(to: tutorialView2(), when: $navTut2)
        }
    }
}


struct tutorialView2: View{
    @StateObject private var tutorial = appStorage()
    @State var goToLevel1 = false
    
    var body: some View{
        VStack{
            ZStack {
                GeometryReader { geo in
                    Image("blank")
                        .resizable()
                        
                        .background{
                            tutorialBuilding()
                                
                                .opacity(0.5)
                                
                        }.frame(width:geo.size.width, height: geo.size.height+150)
                        .fixedSize()
                    .ignoresSafeArea()
                }
                
                GeometryReader { geo in
                    Text("This is your building, Advance through the training to upgrade your knowledge and portfolio, to begin lets jump into the first level")
                        .foregroundColor(.appColorBlack)
                        .font(.custom("American Typewriter", fixedSize: 25))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 45))
                        .background{
                            rectangleBackground(width: 360, height: 250, radiusOfCorners: 10)
                                
                        }.position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY/3)
                    
                    Button{
                        goToLevel1 = true
                    }label:{
                        Text("Advance to\n Level 1")
                            .foregroundColor(.appColorBlack)
                            .multilineTextAlignment(.center)
                            .font(.custom("American Typewriter", fixedSize: 25))
                            .background{
                                rectangleBackground(width: 150, height: 75, radiusOfCorners: 10)
                            }
                        
                    }.position(x: geo.frame(in: .global).midX*1.5, y: geo.frame(in: .global).maxY/1.2)
                }
            }
        }.navigate(to: tutorialLevel1(), when:$goToLevel1)
    }
}

struct tutorialViews_Previews: PreviewProvider {
    static var previews: some View {
        tutorialView2()
    }
}
