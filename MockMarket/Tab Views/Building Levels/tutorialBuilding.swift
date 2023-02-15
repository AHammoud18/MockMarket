//
//  tutorialBuilding.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/9/23.
//

import SwiftUI

struct tutorialBuilding: View{
    @State private var toWorldMap = false
    
    @StateObject private var a = appStorage()
    
    @State var toLevel1 = false
    @State var toLevel2 = false
    @State var toLevel3 = false
    @State var toLevel4 = false
    @State var toLevel5 = false
    @State var toLevel6 = false
    
    @State var notCompletedColor = Color.mint
    @State var completedColor = Color.green
    @State var notCompOrUnlocked = Color.red
    
    func checkWhatColor(comp: Bool, unlocked: Bool) -> Color{
           
        if comp == true{
            return completedColor
        }else{
            if unlocked == true{
                return notCompletedColor
            }else{
                return notCompOrUnlocked
            }
        }
        
    }
    
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        
        GeometryReader{ geo in
            ZStack {
                ZStack{
                    ZStack {
                        
                        // MARK: | Light Mode Variation |
                        if colorScheme == .light{
                            ZStack {
                                Image("lightBackgroundTutorial")
                                    .resizable()
                                
                                ZStack {
                                    Image("tutorialBuilding")
                                        .resizable()
                                        .frame(width: 350, height: 500)
                                        .fixedSize()
                                        .overlay{
                                            
                                            //MARK: Level 1
                                            Button{
                                                toLevel1 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 1, checkLevel: a.level1Comp, checkUnlocked: true)
                                            }.offset(x: -60, y:50)
                                                .disabled(false)
                                            
                                            
                                            //MARK: Level 2
                                            Button{
                                                toLevel2 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 2, checkLevel: a.level2Comp, checkUnlocked: a.level2Unlocked)
                                            }.offset(x: 30, y:50)
                                                .disabled(!a.level2Unlocked)

                                            //MARK: Level 3
                                            Button{
                                                toLevel3 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 3, checkLevel: a.level3Comp, checkUnlocked: a.level3Unlocked)
                                            }.offset(x: 115, y:50)
                                                .disabled(!a.level3Unlocked)
                                            
                                            
                                            //MARK: Level 4
                                            Button{
                                                toLevel4 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 4, checkLevel: a.level4Comp, checkUnlocked: a.level4Unlocked)
                                            }.offset(x: -60, y: -100)
                                                .disabled(!a.level4Unlocked)
                                            
                                            
                                            //MARK: Level 5
                                            Button{
                                               toLevel5 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 5, checkLevel: a.level5Comp, checkUnlocked: a.level5Unlocked)
                                            }.offset(x: 30, y:-100)
                                                .disabled(!a.level5Unlocked)
                                            
                                            
                                            //MARK: Level 6
                                            Button{
                                                toLevel6 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 6, checkLevel: a.level6Comp, checkUnlocked: a.level6Unlocked)
                                            }.offset(x: 115, y:-100)
                                                .disabled(!a.level6Unlocked)
                                        }
                                    Image("tree")
                                        .resizable()
                                        .frame(width: 200, height: 250)
                                        .position(x: geo.frame(in: .global).minX, y: geo.frame(in: .local).midY)
                                        .fixedSize()
                                        

                                        
                                }.position(x:geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                            }
                            
                            
                            
                            
                            
                            
                            
                        }else{
                            //MARK: | Dark Mode Variation |
                            ZStack {
                                Image("darkBackgroundTutorial")
                                    .resizable()
                                
                                ZStack {
                                    Image("darktutorialBuilding")
                                        .resizable()
                                        .frame(width: 350, height: 500)
                                        .fixedSize()
                                        .overlay{
                                            
                                            //MARK: Level 1
                                            Button{
                                                toLevel1 = true
                                                a.backToBuilding = false
                                                
                                            }label:{
                                                tutorialButtonBackground(level: 1, checkLevel: a.level1Comp, checkUnlocked: true)
                                            }.offset(x: -60, y:50)
                                                .disabled(false)
                                            
                                            
                                            //MARK: Level 2
                                            Button{
                                                toLevel2 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 2, checkLevel: a.level2Comp, checkUnlocked: a.level2Unlocked)
                                            }.offset(x: 30, y:50)
                                                .disabled(!a.level2Unlocked)

                                            //MARK: Level 3
                                            Button{
                                                toLevel3 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 3, checkLevel: a.level3Comp, checkUnlocked: a.level3Unlocked)
                                            }.offset(x: 115, y:50)
                                                .disabled(!a.level3Unlocked)
                                            
                                            
                                            //MARK: Level 4
                                            Button{
                                                toLevel4 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 4, checkLevel: a.level4Comp, checkUnlocked: a.level4Unlocked)
                                            }.offset(x: -60, y: -100)
                                                .disabled(!a.level4Unlocked)
                                            
                                            
                                            //MARK: Level 5
                                            Button{
                                                toLevel5 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 5, checkLevel: a.level5Comp, checkUnlocked: a.level5Unlocked)
                                            }.offset(x: 30, y:-100)
                                                .disabled(!a.level5Unlocked)
                                            
                                            
                                            //MARK: Level 6
                                            Button{
                                                toLevel6 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 6, checkLevel: a.level6Comp, checkUnlocked: a.level6Unlocked)
                                            }.offset(x: 115, y:-100)
                                                .disabled(!a.level6Unlocked)
                                        }
                                    Image("tree")
                                        .resizable()
                                        .frame(width: 200, height: 250)
                                        .position(x: geo.frame(in: .global).minX, y: geo.frame(in: .local).midY)
                                        .fixedSize()
                                }.position(x:geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                            }
                        }
                    
                    }.edgesIgnoringSafeArea(.top)
                    
                    if a.isTutorialComplete == false && a.level1Comp == true && a.tutorialPopup == true{
                        Button{
                            a.isTutorialComplete = true
                            a.tutorialPopup = false
                        }label:{
                            Text("Congratulations, you completed our tutorial, continue to learn, and explore the world of stocks, along with our education section, check our our paper-trading portfolio and news sections\nWelcome to the world of Stocks\n(Click this text to continue)")
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                .background{
                                    rectangleBackground(width: geo.size.width-20 , height: geo.size.height/4, radiusOfCorners: 10)
                                }
                        }
                    }
                    
                    if a.isTutorialComplete == true{
                        Button{
                            toWorldMap = true
                            a.fromMap = true
                        }label:{
                            Image(systemName: "map.circle")
                                .font(.system(size: 50))
                                .foregroundColor(Color(uiColor: .lightGray))
                                .accessibilityLabel("City Map")
                                .background{
                                    Circle()
                                        .foregroundColor(.black)
                                        .blur(radius: 10)
                                }
                        }.position(x: geo.frame(in: .global).maxX - 60, y: geo.frame(in: .global).minY)
                    }
                }//.ignoresSafeArea(.container)
                   // .edgesIgnoringSafeArea(.top)
            }
            //.navigate(to: tutorialBuilding(), when: $toTutorialBuilding)
            .fullScreenCover(isPresented: $toWorldMap){
                educationView()
            }
            .fullScreenCover(isPresented: $toLevel1){
                tutorialLevel1()
            }
            .fullScreenCover(isPresented: $toLevel2){
                tutorialLevel2()
            }
            .fullScreenCover(isPresented: $toLevel3){
                tutorialLevel3()
            }
            .fullScreenCover(isPresented: $toLevel4){
                tutorialLevel4()
            }
            .fullScreenCover(isPresented: $toLevel5){
                tutorialLevel5()
            }
            .fullScreenCover(isPresented: $toLevel6){
                tutorialLevel6()
            }
        }
    }
}





struct tutorialLevel1: View{
    @StateObject private var a = appStorage()
    @State var continueTutorial = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
        VStack {
            Text("level1")
            Button{
                a.level1Comp = true
                a.level2Unlocked = true
                if a.isTutorialComplete{
                    dismiss()
                }else{
                    continueTutorial = true
                }
                //dismiss()
            }label:{
                Text("Complete")
            }
        }.navigate(to: tabView(selectedTab: 2), when: $continueTutorial)
    }
}
struct tutorialLevel2: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack {
            Text("level2")
            Button{
                a.backToBuilding = true
                a.level2Comp = true
                a.level3Unlocked = true
                dismiss()
            }label:{
                Text("Complete")
            }
        }//.navigate(to: tutorialBuilding(), when: $a.backToBuilding)
    }
}
struct tutorialLevel3: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack {
            Text("level3")
            Button{
                a.backToBuilding = true
                a.level3Comp = true
                a.level4Unlocked = true
                dismiss()
            }label:{
                Text("Complete")
            }
        }//.navigate(to: tutorialBuilding(), when: $a.backToBuilding)
    }
}
struct tutorialLevel4: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack {
            Text("level4")
            Button{
                a.backToBuilding = true
                a.level4Comp = true
                a.level5Unlocked = true
                dismiss()
            }label:{
                Text("Complete")
            }
        }//.navigate(to: tutorialBuilding(), when: $a.backToBuilding)
    }
}
struct tutorialLevel5: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss

    var body: some View{
        VStack {
            Text("level5")
            Button{
                
                a.backToBuilding = true
                a.level5Comp = true
                a.level6Unlocked = true
                dismiss()
            }label:{
                Text("Complete")
            }
        }.navigate(to: tutorialBuilding(), when: $a.backToBuilding)
    }
}
struct tutorialLevel6: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack {
            Text("level6")
            Button{
                a.backToBuilding = true
                a.level6Comp = true
                dismiss()
            }label:{
                Text("Complete")
            }
        }.navigate(to: tutorialBuilding(), when: $a.backToBuilding)
    }
}



struct tutorialButtonBackground: View{
  @State var t = tutorialBuilding()
    var level: Int
    var checkLevel: Bool
    var checkUnlocked: Bool
    
    var body: some View{
        Text("\(level)")
            .font(.custom("American Typewriter", size: 50))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .blur(radius: 3)
                    .padding(EdgeInsets(top: -10, leading: -10, bottom: -5, trailing: -10))
                    .foregroundColor(t.checkWhatColor(comp:checkLevel, unlocked: checkUnlocked))
            }
    }
}



struct tutorialPreviews: PreviewProvider{
    static var previews: some View{
        tutorialBuilding()
    }
    
    
}
