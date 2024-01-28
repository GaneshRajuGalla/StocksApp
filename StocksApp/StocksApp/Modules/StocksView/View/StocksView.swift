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
    
    
    // MARK: - Body
    
    var body: some View {
        Chart {
            ForEach(stocks,id: \.id){ stock in
                
                // AreaMark
                AreaMark(x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent), y: .value("Stock Price", stock.value))
                    .foregroundStyle(.linearGradient(colors: [Color.pink.opacity(0.3),Color.pink.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                
                // LineMark
                LineMark(x: .value("Date and Time", stock.date,unit: .day,calendar: .autoupdatingCurrent), y: .value("Stock Price", stock.value))
                    .foregroundStyle(Color.white)
            }
        }
        //.chartScrollableAxes(.horizontal)
        .frame(height: 300)
    }
}

#if DEBUG
#Preview {
    StocksView()
        .preferredColorScheme(.dark)
}
#endif
