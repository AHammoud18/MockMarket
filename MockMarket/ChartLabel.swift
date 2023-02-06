
import SwiftUI

public struct ChartLabel: View {
    public var lineChartController: LineChartController
    @StateObject var pointPos = indicatorPos.data
    
    @Binding var indexPosition: Int  // Data point position
    
    public var body: some View {
        ZStack{
            Text("\(lineChartController.prices[indexPosition], specifier: "%.2f")")
                .foregroundColor(lineChartController.labelColor)
                .position(x: pointPos.pricePosition.x)
                .offset(y: 20)
            HStack {
                if let dates = lineChartController.dates {
                     let date = formatStringDate(dates[indexPosition])
                    Text(date)
                        .opacity(0.5)
                        .offset(y: -80)
                }
                
                if let hours = lineChartController.hours {
                    let hour = hours[indexPosition]
                    Text(hour)
                        .opacity(0.5)
                        .offset(y: -80)
                }
            }
        }
    }
    
    /*
     Take string in format yy-MM-dd (2021-01-01) and transform it
     to long default string format
     */
    public func formatStringDate(_ stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        
        // Format date to the final format
        dateFormatter.dateStyle = .long
        let finalDate = dateFormatter.string(from: date!)
        
        return finalDate
    }
}
