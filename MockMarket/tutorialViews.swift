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
        VStack{
            Text("Welcome to The 'Mock Market', our app specializes in educating individuals about learning about and trading in the stock market, to begin choose your education level")
                .font(.custom("American Typewriter", size: 20))
                .multilineTextAlignment(.center)
            
            HStack{
                Button{
                    print("lul")
                }label:{
                    Text("Experienced")
                        .foregroundColor(.appColorWhite)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.appColorBlack)
                            .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                        )
                    
                }
                .opacity(0.5)
                .padding()
                Button{
                    navTut2 = true
                }label:{
                    Text("New to Stocks")
                        .foregroundColor(.appColorWhite)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.appColorBlack)
                            .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                        )
                    
                }
            }
        }.onAppear{
            
        }.navigate(to: tutorialView2(), when: $navTut2)
            .navigate(to: tabView(), when: $tutorial.isTutorialComplete)
    }
}

            
            /// Commented out code to come back to
            //Text("\(test.description)")
            //Text("\(tutorial.isTutorialComplete.description)")
            //            HStack{
            //                Button{
            //                    test = true
            //                    tutorial.isTutorialComplete = true
            //                }label:{
            //                    Text("Tutorial Complete")
            //                        .foregroundColor(.green)
            //                }
            //
            //                Button{
            //                    test = false
            //                    tutorial.isTutorialComplete = false
            //                }label:{
            //                    Text("Tutorial not complete")
            //                        .foregroundColor(.red)
            //                }
            //            }
            //        }.onAppear{
            ////.navigate(to: StockPage(), when: $tutorial.isTutorialComplete)

struct tutorialView2: View{
    @StateObject private var tutorial = appStorage()
    var body: some View{
        VStack{
            Text("Let’s begin with the basics, a stock is a small fraction of a company that you can buy into. With this you are supporting the company and also becoming a very small owner of that company. Stocks go up and down, this is because of more people buying and selling shares. The less amount of people buying a stock the less its worth. ")
                .font(.custom("American Typewriter", size: 24))
                .multilineTextAlignment(.center)
            Spacer()
            Text("Still confused? Don’t worry, let’s go more in depth.")
            Spacer()
            Button{
                tutorial.isTutorialComplete = true
            }label:{
                Text("Next Page")
                    .foregroundColor(.appColorWhite)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.appColorBlack)
                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                    )
                
            }
        }.onAppear{
            ///will eventually be to education page but for right now it just goes to our main pages, since we havent set all dat up yet
        }.navigate(to: StockPage(), when: $tutorial.isTutorialComplete)
    }
}

struct tutorialViews_Previews: PreviewProvider {
    static var previews: some View {
        tutorialViews()
    }
}
