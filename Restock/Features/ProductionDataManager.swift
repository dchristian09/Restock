//
//  ProductionDataManager.swift
//  Restock
//
//  Created by Clarissa Angelia on 27/06/23.

//

import Foundation
import CoreData

class ProductionDataManager: ObservableObject {
    static let shared = ProductionDataManager()
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var productionList:[DataProduction] = []
    @Published var historyDatas:[HistoryData] = []
    
    init() {
        fetchProductionData()
    }
    
    func fetchProductionData(startDate:Date? = nil, endDate:Date? = nil) {
        let request = NSFetchRequest<DataProduction>(entityName: "DataProduction")
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id", "date", "idProduct", "label", "qty", "isProduce"]
        
        if (startDate != nil && endDate != nil){
            let predicate = NSPredicate(format: "date >= %@ && date <= %@", startDate! as CVarArg, endDate! as CVarArg)
            //let predicate = NSPredicate(format: "%K >= %@ && %K < %@", "date", firstDayOfTheMonth! as NSDate, "date", beginningOfNextMonth! as NSDate)
            let sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]

            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
        }
        
        
        do {
            productionList = try viewContext.fetch(request)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            //let nameOfMonth = dateFormatter.string(from: now)
            var monthName = ""
            var historyDetails:[DataProduction] = []
            for production in productionList {
                let nameOfMonth = dateFormatter.string(from: production.date!)
                
                if monthName != nameOfMonth {
                    
                    if monthName != "" {
                        historyDatas.append(
                        HistoryData(historyMonth: monthName,
                                    historyDetails: historyDetails)
                        )
                    }
                    historyDetails = []
                }
                historyDetails.append(production)
            }
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(productionLabel: String, productionDate: Date, productionNotes: String, isProduce: Bool, productionQty: Int32, product_id: UUID) {
        let production = DataProduction(context: viewContext)
        production.id = UUID()
        production.label = productionLabel
        production.date = productionDate
        production.notes = productionNotes
        production.isProduce = isProduce
        production.qty = productionQty
        production.idProduct = product_id
//        company.id = UUID()
//        company.title = companyTitle
//        company.owner = companyOwner

        save()
        self.fetchProductionData()
        print(productionList.count)
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
