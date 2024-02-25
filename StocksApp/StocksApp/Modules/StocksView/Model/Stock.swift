//
//  Stock.swift
//  StocksApp
//
//  Created by Ganesh Raju Galla on 28/01/24.
//

import Foundation

struct Stock:Identifiable{
    let id:UUID
    let date: Date
    let value:Int
        
    static func getData() -> [Stock] {
        var stocks = [Stock]()
        let startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 31))!
        
        var currentDate = startDate
        while currentDate <= endDate {
            let randomValue = Int.random(in: 4000...7000)
            let stock = Stock(id: UUID(), date: currentDate, value: randomValue)
            stocks.append(stock)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return stocks
    }
}

