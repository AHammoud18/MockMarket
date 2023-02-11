//
//  portfolioSwitcherView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/10/23.
//

import SwiftUI

struct portfolioSwitcherView: View {
    @State var currentGraphTab: dateGraphTab = .today
    
    enum dateGraphTab{
        case today
        case oneWk
        case oneMo
        case sixMo
        case oneYr
        case all
    }
    
    func switchGraphTab() -> String{
        ///eventually change these to graphs not strings
        switch self.currentGraphTab {
        case .today:
            return "Today"
        case .oneWk:
            return "OneWk"
        case .oneMo:
            return "OneMo"
        case .sixMo:
            return "YTD"
        case .oneYr:
            return "oneYR"
        case .all:
            return "all"
        }
        
    }
    var body: some View {
        ZStack {
            portfolioDateSwitcherView()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ///today
                    Button{
                        currentGraphTab = .today
                    }label:{
                        ZStack{
                            Text("Today")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .today) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .today) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .today{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 95, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    
                    

                    ///1W
                    Button{
                        currentGraphTab = .oneWk
                    }label:{
                        ZStack{
                            Text("1W")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .oneWk) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .oneWk) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .oneWk{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 70, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))

                    ///1M
                    Button{
                        currentGraphTab = .oneMo
                    }label:{
                        ZStack{
                            Text("1M")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .oneMo) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .oneMo) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .oneMo{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 70, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                    ///6M
                    Button{
                        currentGraphTab = .sixMo
                    }label:{
                        ZStack{
                            Text("6M")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .sixMo) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .sixMo) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .sixMo{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 70, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                    ///1Yr
                    Button{
                        currentGraphTab = .oneYr
                    }label:{
                        ZStack{
                            Text("1YR")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .oneYr) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .oneYr) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .oneYr{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 70, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                    ///All
                    Button{
                        currentGraphTab = .all
                    }label:{
                        ZStack{
                            Text("All")
                                .font(.custom("American Typewriter", size: 17))
                                .fontWeight((currentGraphTab == .all) ? .bold : .none)
                                .foregroundColor((currentGraphTab == .all) ? .appColorWhite : .appColorBlack)
                                .background{
                                    if currentGraphTab == .all{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 70, height: 50)
                                            .foregroundColor(.appColorBlack)
                                    }
                                }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    

                }.frame(height: 50)
                    .dynamicTypeSize(.xxxLarge)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
            }.frame(width: 350)
        }

    }
}

struct portfolioSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        portfolioSwitcherView()
    }
}
