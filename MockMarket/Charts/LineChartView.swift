
import SwiftUI

//
public struct LineChartView: View {
    public var lineChartController: LineChartController
    
    @State var showingIndicators = false
    @State var indexPosition = Int()
    
    public init(lineChartController: LineChartController) {
        self.lineChartController = lineChartController
    }
    
    public var body: some View {
        if lineChartController.prices.isEmpty {
            
        } else {
            VStack {
                if lineChartController.dragGesture {
                    ChartLabel(lineChartController: lineChartController, indexPosition: $indexPosition)
                        .opacity(showingIndicators ? 1: 0)
                }
                
                LineView(
                    lineChartController: lineChartController,
                    indexPosition: $indexPosition,
                    showingIndicators: $showingIndicators
                )
            }
        }
    }
}

