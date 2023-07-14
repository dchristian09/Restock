//
//  History_Data.swift
//  Restock
//
//  Created by Farid Azhari on 10/07/23.
//

import Foundation

class HistoryData: ObservableObject {
    @Published var historyMonth:String
    //@Published var historyDetails:[HistoryDetail]
    
    @Published var historyDetails:[DataProduction]
    
    init(historyMonth: String, historyDetails:[DataProduction]) {
        self.historyMonth = historyMonth
        self.historyDetails = historyDetails
        
    }
}

struct HistoryDetail: Hashable{
    var historyDate:Date
    var itemName:String
    var productionLabel:String
    var quantity:Int
    var isProduce:Bool
}
