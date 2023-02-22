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
    @State var selectedLevel = 1
    @State var didSelectLevel = false
    @State var toLevel1 = false
    @State var toLevel2 = false
    @State var toLevel3 = false
    @State var toLevel4 = false
    @State var toLevel5 = false
    @State var toLevel6 = false
    
    @State var notCompletedColor = Color.mint
    @State var completedColor = Color.green
    @State var notCompOrUnlocked = Color.red
    
    @State var floating = false
    
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
            let X = geo.frame(in: .global)
            let Y = geo.frame(in: .global)
            Rectangle()
                .foregroundColor(.appColorWhite)
            Image("gridPaper")
                .offset(y: -100)
            ZStack{
                Image("MockTree2")
                    .resizable()
                    .frame(width: 650, height: 600)
                    .offset(x: -160, y: self.floating ? 180 : 200)
                    .shadow(radius: 4,x: 20,y: 20)
                Image("MockBuilding")
                    .resizable()
                    .frame(width: 650, height: 600)
                    .offset(x: -15)
                    .shadow(radius: 4)
                Image("MockTree1")
                    .resizable()
                    .frame(width: 650, height: 600)
                    .offset(y: self.floating ? -19 : 0.0)
                    .position(x: X.midX*2.1, y: Y.midY*1.6)
                    .shadow(radius: 4)
                    .onAppear(){
                        /*withAnimation(.easeInOut(duration: 4).repeatForever()){
                            self.floating.toggle()
                        }*/
                    }
                
                    
            }.position(x: X.midX, y: Y.midY)
                .overlay(
                    ZStack{
                        // first two floors
                        ForEach(1..<3){ value in
                            Button{
                                print("level: \(value)")
                                self.selectedLevel = value
                                self.didSelectLevel.toggle()
                            }label:{Rectangle().frame(width: 60, height: 70)}
                                //.offset(x: CGFloat(value.self * 190))
                                .offset(x: X.midX * Double(value.self)*1)
                                .position(x: X.midX * -0.5, y: Y.midY*1.33)
                                .overlay(
                                    Text("\(value)")
                                        .font(.custom("American Typewriter", fixedSize: 60))
                                        .position(x: (X.midX*0.88 * CGFloat(value)), y: Y.midY*1.32)
                                        .offset(x: -70)
                                        
                                        
                                )
                        }
                        // quiz level (second floor)
                        Button{
                            print("quiz: 1")
                            self.selectedLevel = 3
                            self.didSelectLevel.toggle()

                        }label:{Rectangle().frame(width: 40, height: 60)}
                            .position(x: X.midX, y: Y.midY*1.14)
                        // third floor
                        ForEach(4..<6){ value in
                            Button{
                                print("level: \(value)")
                                self.selectedLevel = value
                                self.didSelectLevel.toggle()

                            }label:{Rectangle().frame(width: 60, height: 70)}
                                .position(x: X.midX * -3.22, y: Y.midY*0.9)
                                .offset(x: X.midX * Double(value.self)*0.94)
                                .overlay(
                                    Text("\(value)")
                                        .font(.custom("American Typewriter", fixedSize: 60))
                                        .position(x: X.midX*0.9 * CGFloat(value), y: Y.midY)
                                        .offset(x: -geo.size.width*1.53, y: -40)
                                )
                        }
                        // quiz level (fourth floor)
                        Button{
                            print("quiz: 2")
                            self.selectedLevel = 6
                            self.didSelectLevel.toggle()

                        }label:{Rectangle().frame(width: 40, height: 60)}
                            .position(x: X.midX, y: Y.midY*0.7)
                    }
                )
                
        }//.navigate(to: level(level: self.selectedLevel), when: $didSelectLevel)
            .sheet(isPresented: $didSelectLevel){
                level(level: self.selectedLevel)
            }
    }
        
    /*var body: some View{
        
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
                                    Image("MockBuilding")
                                        .resizable()
                                        .frame(width: 700, height: 650)
                                        .fixedSize()
                                        .position
                                        .overlay{
                                            
                                            //MARK: Level 1
                                            Button{
                                                toLevel1 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 1, checkLevel: a.level1Comp, checkUnlocked: true)
                                                    .dynamicTypeSize(.xxLarge)
                                            }
                                            
                                            .offset(x: -60, y:50)
                                                .disabled(false)
                                            
                                            
                                            //MARK: Level 2
                                            Button{
                                                toLevel2 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 2, checkLevel: a.level2Comp, checkUnlocked: a.level2Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 30, y:50)
                                                .disabled(!a.level2Unlocked)

                                            //MARK: Level 3
                                            Button{
                                                toLevel3 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 3, checkLevel: a.level3Comp, checkUnlocked: a.level3Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 115, y:50)
                                                .disabled(!a.level3Unlocked)
                                            
                                            
                                            //MARK: Level 4
                                            Button{
                                                toLevel4 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 4, checkLevel: a.level4Comp, checkUnlocked: a.level4Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: -60, y: -100)
                                                .disabled(!a.level4Unlocked)
                                            
                                            
                                            //MARK: Level 5
                                            Button{
                                               toLevel5 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 5, checkLevel: a.level5Comp, checkUnlocked: a.level5Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 30, y:-100)
                                                .disabled(!a.level5Unlocked)
                                            
                                            
                                            //MARK: Level 6
                                            Button{
                                                toLevel6 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 6, checkLevel: a.level6Comp, checkUnlocked: a.level6Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 115, y:-100)
                                                .disabled(!a.level6Unlocked)
                                        }
                                    Image("MockTree1")
                                        .resizable()
                                        .frame(width: 800, height: 650)
                                        .position(x: geo.frame(in: .global).midX*1.35, y: geo.frame(in: .local).midY*0.9)
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
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: -60, y:50)
                                                .disabled(false)
                                            
                                            
                                            //MARK: Level 2
                                            Button{
                                                toLevel2 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 2, checkLevel: a.level2Comp, checkUnlocked: a.level2Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 30, y:50)
                                                .disabled(!a.level2Unlocked)

                                            //MARK: Level 3
                                            Button{
                                                toLevel3 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 3, checkLevel: a.level3Comp, checkUnlocked: a.level3Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 115, y:50)
                                                .disabled(!a.level3Unlocked)
                                            
                                            
                                            //MARK: Level 4
                                            Button{
                                                toLevel4 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 4, checkLevel: a.level4Comp, checkUnlocked: a.level4Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: -60, y: -100)
                                                .disabled(!a.level4Unlocked)
                                            
                                            
                                            //MARK: Level 5
                                            Button{
                                                toLevel5 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 5, checkLevel: a.level5Comp, checkUnlocked: a.level5Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
                                            }.offset(x: 30, y:-100)
                                                .disabled(!a.level5Unlocked)
                                            
                                            
                                            //MARK: Level 6
                                            Button{
                                                toLevel6 = true
                                                a.backToBuilding = false
                                            }label:{
                                                tutorialButtonBackground(level: 6, checkLevel: a.level6Comp, checkUnlocked: a.level6Unlocked)
                                                    .dynamicTypeSize(.xxLarge)
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
                tabView(selectedTab: 2)
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
    }*/
} // end of struct

struct level: View{
    @State var level: Int
    
    init(level: Int) {
        self.level = level
    }
    
    var body: some View{
        ZStack{
            checkLevel()
        }
    }
    @ViewBuilder
    func checkLevel() -> some View{
        if self.level == 1{
            tutorialLevel1()
        }
        else if self.level == 2{
            tutorialLevel2()
        }
        else if self.level == 3{
            tutorialLevel3()
        }
        else if self.level == 4{
            tutorialLevel4()
        }
        else if self.level == 5{
            tutorialLevel5()
        }
        else if self.level == 6{
            tutorialLevel6()
        }
    }
}


struct beginnerLevel: View{
    @StateObject private var a = appStorage()
    var body: some View{
        VStack{
            Text("Testing")
            Button{
                a.isTutorialComplete = true
            }label:{
                Text("Complete beginner")
            }
        }.navigate(to: tabView(), when: $a.isTutorialComplete)
    }
}


struct tutorialLevel1: View{
    @StateObject private var a = appStorage()
    @Environment(\.dismiss) var dismiss
    @State private var dateFormat = DateFormatter()
    @State private var currentPage = 0
    
    let limit = 4
    @State var name: String = "" {
        didSet{
            if name.count > limit {
                name = String(name.prefix(limit))
            }
        }
    }
    @State var date: String = ""
    
    @ViewBuilder
    func pages() -> some View{
        switch currentPage{
        case 0:
            pageOne
        case 1:
            pageTwo
        case 2:
            pageThree
        case 3:
            pageFour
        case 4:
            pageFive
        case 5:
            pageSix
        case 6:
            pageSeven
        case 7:
            pageEight
        case 8:
            pageNine
        case 9:
            pageTen
        default:
            tutorialBuilding()
        }
    }
    
    var body: some View{
        GeometryReader{ geo in
            let X = geo.frame(in: .local)
            let Y = geo.frame(in: .local)
            ZStack {
                    ZStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 80, height: 60)
                            .offset(x: -300, y: -26)
                        Rectangle()
                            .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                            .frame(width: 40, height: 420)
                            .rotationEffect(Angle(degrees: -45))
                        Rectangle()
                            .foregroundColor(Color(red: 0.19, green: 0.20, blue: 0.21))
                            .frame(width: 40, height: 420)
                            .rotationEffect(Angle(degrees: -45))
                            .offset(x: 10, y: -70)
                        
                    }.padding()
                    .position(x: geo.size.width*0.90, y: geo.size.height*0.09)
                        .overlay(
                            pages()
                        )
                    /*.overlay(
                        VStack{
                            TextField("name:", text: $name)
                                .multilineTextAlignment(.trailing)
                                .lineLimit(1)
                                .keyboardType(.default)
                            Text(dateFormat.string(from: Date.now))
                                .multilineTextAlignment(.trailing)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .offset(x: 180)
                        }.position(x: geo.size.width*0.45, y: geo.size.height/18)
                            .onAppear{
                                dateFormat.dateFormat = "MM-dd-yy"
                            }
                            
                    )*/
                /*
                 Button{
                 a.level1Comp = true
                 a.level2Unlocked = true
                 dismiss()
                 }label:{
                 Text("Complete")
                 }*/
            }.onAppear{

            }
        }
    }
    
    var pageOne : some View{
        GeometryReader{ geo in
            VStack{
                Text("Hey, whats up..\nIm your mentor [Name]\n\n")
                    .multilineTextAlignment(.center)
                //.offset(y: -60)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    .font(.custom("American Typewriter", fixedSize: 30))
                    .bold()
                Text("Before we get into this level, lets talk about some facts!")
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    .font(.custom("American Typewriter", fixedSize: 30))
                    .bold()
                //.offset(y: 40)
                Button{
                    self.currentPage += 1
                }label:{
                    GroupBox{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .overlay(
                                Text("Get Started")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.custom("American Typewriter", fixedSize: 18))
                            )
                    }.groupBoxStyle(ChartBox())
                        .frame(width: 120, height: 60)
                }//.offset(y: 180)
                
                
            }.position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    var pageTwo: some View{
        GeometryReader{ geo in
            VStack{
                VStack{
                    Text("As of Sep. 13th, 2022\n more than")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 20))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -30)
                    Text("64 million Americans")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 20))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -30)
                    Text(" hold credit card debt…")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 20))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -30)
                    Text("crazy right?")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                }.overlay(
                    ZStack{
                        Button{
                            self.currentPage += 1
                        }label:{
                            GroupBox{
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.white)
                                    .overlay(Text("Yes, very crazy")
                                        .foregroundColor(.black)
                                        .font(.custom("American Typewriter", fixedSize: 18)))
                            }.groupBoxStyle(ChartBox())
                                .frame(width: 120, height: 60)
                        }.position(x: geo.size.width/3.2, y: geo.size.height/2.5)
                        Button{
                            self.currentPage += 1
                        }label:{
                            GroupBox{
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.white)
                                    .overlay(Text("No, not crazy").foregroundColor(.black)
                                        .font(.custom("American Typewriter", fixedSize: 18)))
                            }.groupBoxStyle(ChartBox())
                                .frame(width: 120, height: 60)
                        }.position(x: geo.size.width/1.4, y: geo.size.height/2.5)
                    }
                )
            }.position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    var pageThree: some View{
        GeometryReader{ geo in
            VStack{
                VStack{
                    Text("We at Mock Market believe that one of the main causes for this national debt crisis is the lack of knowledge that Americans have about where to allocate their income. ")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -120)
                    Text("ie. What to spend it on")
                        .multilineTextAlignment(.center)
                        .font(.custom("American Typewriter", fixedSize: 18))
                        //.offset(y: -110)
                }
                Button{
                    self.currentPage += 1
                }label:{
                    GroupBox{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .overlay(Text("Affirmative").foregroundColor(.black)
                                .font(.custom("American Typewriter", fixedSize: 18)))
                    }.groupBoxStyle(ChartBox())
                        .frame(width: 120, height: 60)
                    
                }
                //.offset(y: 100)
            }.position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    var pageFour: some View{
        GeometryReader{ geo in
            VStack{
                VStack{
                    Text("Throughout the past years involving hectic crypto trading and the rise of Reddits like wallstreet bets, many of us have come to the conclusion that investing into the stock market seems alottttttt like gambling...")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -120)
                    Text("(just not as fun)")
                        .font(.custom("American Typewriter", fixedSize: 18))
                        .multilineTextAlignment(.center)
                        //.offset(y: -110)
                }
                Button{
                    self.currentPage += 1
                }label:{
                    GroupBox{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .overlay(Text("Okay, and?").foregroundColor(.black)
                                .font(.custom("American Typewriter", fixedSize: 18)))
                    }.groupBoxStyle(ChartBox())
                        .frame(width: 120, height: 60)
                }
                //.offset(y: 100)
            }.position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    var pageFive: some View{
        GeometryReader{ geo in
            VStack{
                VStack{
                    Text("Given your influence,\n we can’t say we blame you..")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -120)
                    Text("But here at Mock Market, our goal is to teach you otherwise.")
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        //.offset(y: -110)
                }
                Button{
                    self.currentPage += 1
                }label:{
                    GroupBox{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .overlay(Text("Deal.").foregroundColor(.black)
                                .font(.custom("American Typewriter", fixedSize: 18)))
                    }.groupBoxStyle(ChartBox())
                        .frame(width: 120, height: 60)
                }
                //.offset(y: 100)
            }.position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    
    var pageSix: some View{
        GeometryReader { geo in
            VStack{
                // V Stack for text
                VStack{
                    Text("Let's jump into the main topic of this lesson")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                        .offset(y: -30)
                    Text("What is a stock?")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                }
                // Z Stack for buttons
                ZStack{
                    Button{
                        self.currentPage += 1
                    }label:{
                        GroupBox{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Lets Find Out").foregroundColor(.black)
                                    .font(.custom("American Typewriter", fixedSize: 18))
                                )
                        }.groupBoxStyle(ChartBox())
                            .frame(width: 120, height: 60)
                        
                    }
                }
                
            }// main VStack
            .position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    
    var pageSeven: some View{
        GeometryReader { geo in
            VStack{
                // V Stack for text
                VStack{
                    Text("According to Merriam Webster, a stock is “the proprietorship element in a corporation usually divided into shares and represented by transferable certificates”")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("But honestly, I could read that 28 more times and still have no idea what a Stock is..")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("let's simplify...")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                }
                // Z Stack for buttons
                ZStack{
                    Button{
                        self.currentPage += 1
                    }label:{
                        GroupBox{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Next").foregroundColor(.black)
                                    .font(.custom("American Typewriter", fixedSize: 18))
                                )
                        }.groupBoxStyle(ChartBox())
                            .frame(width: 120, height: 60)
                        
                    }
                }
                
            }// main VStack
            .position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    
    var pageEight: some View{
        GeometryReader { geo in
            VStack{
                // V Stack for text
                VStack{
                    Text("Stocks are...")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("*shares in the ownership of a company*")
                        .underline(true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("Purchasing a share of a stock is equivalent to purchasing a small piece of X company. This is called a share.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("Investors purchase stocks in companies that they think will go up in value. The share of that stock can then be sold for a profit.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                }
                // Z Stack for buttons
                ZStack{
                    Button{
                        self.currentPage += 1
                    }label:{
                        GroupBox{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Next").foregroundColor(.black)
                                    .font(.custom("American Typewriter", fixedSize: 18))
                                )
                        }.groupBoxStyle(ChartBox())
                            .frame(width: 120, height: 60)
                        
                    }
                }
                
            }// main VStack
            .position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    var pageNine: some View{
        GeometryReader { geo in
            VStack{
                // V Stack for text
                VStack{
                    Text("When you own stock in a company, you are called a shareholder because you share in the company’s profits.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 26))
                        .bold()
                    Text("Becoming a shareholder in these companies has become easier than ever due to rapid technological advancement. Nowadays, you can invest thousands into a company in a matter of seconds through apps like Robinhood, WeBull, M1Finance, and so many more.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 26))
                        .bold()
                }
                // Z Stack for buttons
                ZStack{
                    Button{
                        self.currentPage += 1
                    }label:{
                        GroupBox{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Next").foregroundColor(.black)
                                    .font(.custom("American Typewriter", fixedSize: 18))
                                )
                        }.groupBoxStyle(ChartBox())
                            .frame(width: 120, height: 60)
                        
                    }
                }
                
            }// main VStack
            .position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
    }
    
    
    var pageTen: some View{
        GeometryReader { geo in
            VStack{
                // V Stack for text
                VStack{
                    Text("Here at Mock Market, we replicate the real time stock market whilst utilizing a fake currency to allow the user to learn and become familiar with trading stocks with absoloutely zero risk.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                    Text("Our end goal is to send our students off into their Real investing journey with Real currency.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.custom("American Typewriter", fixedSize: 30))
                        .bold()
                }
                // Z Stack for buttons
                ZStack{
                    Button{
                        a.level1Comp = true
                        dismiss()
                    }label:{
                        GroupBox{
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Complete Lesson").foregroundColor(.accentColor)
                                    .font(.custom("American Typewriter", fixedSize: 18))
                                    .bold()
                                )
                        }.groupBoxStyle(ChartBox())
                            .frame(width: 120, height: 60)
                        
                    }
                }
                
            }// main VStack
            .position(x: geo.size.width/2 ,y: geo.size.height/2)
        }
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
        }
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
        }
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
        //tutorialLevel1()
    }
    
    
}

