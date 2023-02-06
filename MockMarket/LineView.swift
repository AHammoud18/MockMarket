
import SwiftUI
//
class indicatorPos: ObservableObject{
    static let data = indicatorPos()
    @Published var indicatorPosition: CGPoint = .zero
    @Published var pricePosition: CGPoint = .zero
    @Published var latestTime: CGFloat = .zero
    @Published var showingIndicator: Bool = false
    let indicatorColor = Color.cyan
    @Published var maxPrice: Double = .zero
    @Published var latestPrice: CGFloat = .zero
    @Published var selectedRange: Int = 0
    @Published var isDayChart = false

}

public struct LineView: View {
    public var lineChartController: LineChartController
    @State var deviceX: Double?
    @State var deviceY: Double?
    @Binding var indexPosition: Int
    @StateObject var pointPos = indicatorPos.data
    @State var IndicatorPointPosition: CGPoint = .zero
    @Binding var showingIndicators: Bool

    @State var pathPoints = [CGPoint]()
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                LinePath(data: lineChartController.prices, width: proxy.size.width, height: proxy.size.height*1.8 , pathPoints: $pathPoints)
                    .stroke(colorLine(), lineWidth: 2)
                    .shadow(color: colorLine(), radius: 2)
                    .onAppear{
                        self.pointPos.maxPrice = lineChartController.prices.max() ?? 1.0
                        debugPrint(pointPos.maxPrice)
                        deviceX = proxy.size.width
                        deviceY = proxy.size.height
                    }
            }
            if showingIndicators {
                IndicatorPoint(lineChartController: lineChartController)
                    .position(x: IndicatorPointPosition.x, y: IndicatorPointPosition.y)
            }
        }
        .rotationEffect(.degrees(180), anchor: .center)
        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
        .contentShape(Rectangle())  // Control tappable area
        .gesture(lineChartController.dragGesture ?
            LongPressGesture(minimumDuration: 0.2)
                .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                .onChanged({ value in  // Get value of the gesture
                    switch value {
                    case .second(true, let drag):
                        if let longPressLocation = drag?.location {
                            dragGesture(longPressLocation)
                        }
                    default:
                        break
                    }
                })
                // Hide indicator when finish
                .onEnded({ value in
                    self.showingIndicators = false
                    self.pointPos.showingIndicator = false
                })
            : nil  // On dragGesture = false
        )
    }
    
    /*
     Color path depending on data.
     */
    public func colorLine() -> Color {
        var color = lineChartController.uptrendLineColor
        
        if showingIndicators {
            color = lineChartController.showingIndicatorLineColor
        } else if lineChartController.prices.first! > lineChartController.prices.last! {
            color = lineChartController.downtrendLineColor
        } else if lineChartController.prices.first! == lineChartController.prices.last! {
            color = lineChartController.flatTrendLineColor
        }
        
        return color
    }
    
    /*
     When the user drag on Path -> Modifiy indicator point to move it on the path accordingly
     */
    public func dragGesture(_ longPressLocation: CGPoint) {
        
        let (closestXPoint, closestYPoint, yPointIndex) = getClosestValueFrom(longPressLocation, inData: pathPoints)
        
        self.pointPos.pricePosition.x = max( ((deviceX ?? 0.0) * 0.2), min(closestXPoint, 290))
        self.pointPos.indicatorPosition.x = closestXPoint
        self.IndicatorPointPosition.x = closestXPoint
        self.IndicatorPointPosition.y = closestYPoint
        self.showingIndicators = true
        self.pointPos.showingIndicator = true
        self.indexPosition = yPointIndex
    }
    
    public func latestPrice(inData: [CGPoint]){
        let value = CGPoint(x: 10, y: 10)
        let touchPoint: (CGFloat, CGFloat) = (value.x, value.y)
        let xPathPoints = inData.map { $0.x }
        let yPathPoints = inData.map { $0.y }
        
        // Closest X value
        debugPrint(yPathPoints.last)
    }
    
    /*
     First, search the closest X point in Path from the tapped location.
     Then, find the correspondent Y point in Path.
     */
    public func getClosestValueFrom(_ value: CGPoint, inData: [CGPoint]) -> (CGFloat, CGFloat, Int) {
        let touchPoint: (CGFloat, CGFloat) = (value.x, value.y)
        let xPathPoints = inData.map { $0.x }
        let yPathPoints = inData.map { $0.y }
        
        // Closest X value
        let closestXPoint = xPathPoints.enumerated().min( by: { abs($0.1 - touchPoint.0) < abs($1.1 - touchPoint.0) } )!
        let closestYPointIndex = xPathPoints.firstIndex(of: closestXPoint.element)!
        let closestYPoint = yPathPoints[closestYPointIndex]
        // Index of the closest points in the array
        let yPointIndex = yPathPoints.firstIndex(of: closestYPoint)!

        return (closestXPoint.element, closestYPoint, yPointIndex)
    }
}
