
import SwiftUI
//
public struct IndicatorPoint: View {
    public var lineChartController: LineChartController
    @StateObject var pointPos = indicatorPos.data

    public var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(lineChartController.indicatorPointColor)
            .shadow(color: pointPos.indicatorColor, radius: 2)

    }
}
