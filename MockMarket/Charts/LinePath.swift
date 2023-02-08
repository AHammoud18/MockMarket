
import SwiftUI
//
public struct LinePath: Shape {
    public var data: [Double]
    public var (width, height): (CGFloat, CGFloat)
    @State private var latestPrice: CGFloat = .zero
    @Binding var pathPoints: [CGPoint]
    

    
    var pointPos = indicatorPos.data    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        var pathPoints = [CGPoint]()
        
        let normalizedData = normalize(data)
        let widthBetweenDataPoints = Double(width) / Double(normalizedData.count - 1)  // Remove first point
        let initialPoint = normalizedData[0] * Double(height)
        var x: Double = 0
        path.move(to: CGPoint(x: x, y: initialPoint))
        for y in normalizedData {
            if normalizedData.firstIndex(of: y) != 0 {  // Skip first point
                x += widthBetweenDataPoints
                let y = y * Double(height)
                path.addLine(to: CGPoint(x: x, y: y))
                
            }
            
            // Append current point to an array. Later will be used for Drag Gesture
            pathPoints.append(path.currentPoint ?? CGPoint(x: 0, y: 0))
            
        }
        debugPrint(pathPoints.last?.y ?? 0.0)
        
        DispatchQueue.main.async {
            self.pathPoints = pathPoints
            self.pointPos.latestPrice = pathPoints.last?.y ?? 0.0
        }
        return path
    }
    
    /*
     Get data -> normalize it -> 0 <= output <= 1
     */
    public func normalize(_ data: [Double]) -> [Double] {
        var normalData = [Double]()
        
        
        let min = data.min()!
        let max = data.max()!

        for value in data {
            let normal = (value - min) / (max - min)
            normalData.append(normal)
        }
        
        return normalData
    }
}

