//
//  Date.swift
//  StocksApp
//
//  Created by Ganesh Raju Galla on 28/01/24.
//

import Foundation

extension Date{
    init(year:Int,month:Int,day:Int){
        let calender = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        self = calender.date(from: components)!
    }
}
