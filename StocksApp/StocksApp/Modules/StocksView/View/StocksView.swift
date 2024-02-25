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
    @State private var selectedStockValue: Int?
    private var chartColor:Color{
        selectedDate != nil ? .cyan : .green
    }
    let yValues = stride(from: 4000, to: 7000, by: 1000).map { $0 }
    
    // MARK: - Body
    var body: some View {
        Chart {
            ForEach(stocks,id: \.id){ stock in
                
                // AreaMark
                AreaMark(
                    x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent),
                    yStart: .value("Stock Price", stock.value),
                    yEnd: .value("Stock Price", 4000))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.linearGradient(colors: [chartColor.opacity(0.3),chartColor.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                
                
                // LineMark
                LineMark(x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent), y: .value("Stock Price", stock.value))
                    .foregroundStyle(chartColor)
                
                if let selectedDate{
                    RuleMark(x: .value("Stock Price", selectedDate))
                        .foregroundStyle(chartColor)
                        .annotation(position: .top) {
                            Text(selectedStockValue?.description ?? "???")
                                .font(.system(size: 13))
                                .foregroundStyle(chartColor)
                        }
                }
                
                if let selectedDate, let selectedStockValue {
                    PointMark(
                        x: .value("日時", selectedDate),
                        y: .value("株価", selectedStockValue)
                    )
                    .symbol {
                        Circle()
                            .fill()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(chartColor)
                            .shadow(radius: 1)
                    }
                }
            }
        }
        .frame(height:250)
        .chartXScale(domain: Date(year: 2024, month: 1, day: 1) ... Date(year: 2024, month: 1, day: 31))
        .chartYScale(domain: 4000 ... 7000)
        .chartXSelection(value: $selectedDate)
        .chartGesture { chartProxy in
            DragGesture(minimumDistance: 0)
                .onChanged {
                    chartProxy.selectXValue(at: $0.location.x)
                }
                .onEnded { _ in
                    selectedDate = nil
                    selectedStockValue = nil
                }
        }
        .onChange(of: selectedDate) {
            guard let selectedDate else { return }
            selectedStockValue = stocks.first(where: {
                selectedDate.formatted(.iso8601.year().month().day())
                == $0.date.formatted(.iso8601.year().month().day())
            })?.value
        }
    }
}

#if DEBUG
#Preview {
    StocksView()
        .preferredColorScheme(.dark)
}
#endif
