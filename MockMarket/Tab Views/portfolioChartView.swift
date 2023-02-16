//
//  portfolioChartView.swift
//  MockMarket
//
//  Created by Maverick Brazill on 2/10/23.
//

import SwiftUI

struct portfolioChartView: View {
    @State var userValue = [14.50, 12.00, 18.25, 22.50, 8.00, 45.00]
    @State var userDates = ["23-1-11","23-1-13","23-1-14","23-1-16","23-1-20","23-1-22"]
    @State var priceColor = true
    @StateObject var stockInfo = StockData.data
    @StateObject var pointPos = indicatorPos.data
    @State var didSelectStock = false
    @State var selectedStock: String?
    var body: some View {
        ZStack(alignment: .center){
            //VStack{
            GroupBox{
                LineChartView(
                    lineChartController: LineChartController(
                        prices: self.userValue,
                        dates: self.userDates,
                        indicatorPointColor: self.pointPos.indicatorColor,
                        dragGesture: true
                    )
                )


            }.groupBoxStyle(ChartBox())
                .frame(height: 300)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
        }.accessibilityHidden(true)
    }
}

struct portfolioChartView_Previews: PreviewProvider {
    static var previews: some View {
        portfolioChartView()
    }
}
