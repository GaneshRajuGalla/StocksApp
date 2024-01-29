//
//  StocksView.swift
//  StocksApp
//
//  Created by Ganesh Raju Galla on 28/01/24.
//

import SwiftUI
import Charts

struct StocksView: View {
    
    // MARK: - Properties
    
    @State private var stocks:[Stock] = Stock.getData()
    @State private var selectedDate:Date?
    private var chartColor:Color{
        selectedDate != nil ? .cyan : .green
    }
    
    
    // MARK: - Body
    
    var body: some View {
        Chart {
            ForEach(stocks,id: \.id){ stock in
                
                // AreaMark
                AreaMark(x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent), y: .value("Stock Price", stock.value))
                    .foregroundStyle(.linearGradient(colors: [chartColor.opacity(0.3),chartColor.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                
                // LineMark
                LineMark(x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent), y: .value("Stock Price", stock.value))
                    .foregroundStyle(chartColor)
                
                if let selectedDate{
                    RuleMark(x: .value("Stock Price", selectedDate))
                        .foregroundStyle(chartColor)
                }
            }
        }
        .frame(height: 250)
        .chartXSelection(value: $selectedDate)
        .chartGesture { chartProxy in
            DragGesture(minimumDistance: 0)
                .onChanged {
                    chartProxy.selectXValue(at: $0.location.x)
                }
                .onEnded { _ in
                    selectedDate = nil
                }
        }
    }
}

#if DEBUG
#Preview {
    StocksView()
        .preferredColorScheme(.dark)
}
#endif
