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
    
    @Published var productionList : [DataProduction] = []
    @Published var historyDatas : [HistoryData] = []
    
    @Published var selectedType: String = "product" {
        didSet {
            fetchProductionData()
        }
    }
    
    init() {
        fetchProductionData()
    }
    
    func fetchProductionData(startDate:Date? = nil, endDate:Date? = nil) {
        historyDatas = []
        let request = NSFetchRequest<DataProduction>(entityName: "DataProduction")
//        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id", "date", "idProduct", "label", "qty", "isProduce"]
        let sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.sortDescriptors = sortDescriptors
        
        if (startDate != nil && endDate != nil){
            let predicate = NSPredicate(format: "date >= %@ && date <= %@", startDate! as CVarArg, endDate! as CVarArg)
            //let predicate = NSPredicate(format: "%K >= %@ && %K < %@", "date", firstDayOfTheMonth! as NSDate, "date", beginningOfNextMonth! as NSDate)
            
            request.predicate = predicate
        }
        
        
        do {
            productionList = try viewContext.fetch(request)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM YYYY"
            //let nameOfMonth = dateFormatter.string(from: now)
            var monthName = ""
            
//            var filteredProductionList : [DataProduction] = productionList.filter{
//                $0.itemType == selectedType
//            }
            
            productionList = productionList.filter { data in
                if let itemType = data.itemType {
                    print("ItemType", itemType.lowercased())
                    print("selected", selectedType.lowercased())
                    print(itemType.lowercased() == selectedType.lowercased())
                    return itemType.lowercased() == selectedType.lowercased()
                }else{
                    return false
                }
                
            }
            print("SELECTED TYPE: ", selectedType)
            print("filteredProductionList: ", productionList.count)
            
            var historyMonthDetails:[DataProduction] = []
            for (index, production) in productionList.enumerated() {
                
                let nameOfMonth = dateFormatter.string(from: production.date!)

                if monthName == "" || (monthName == nameOfMonth && index != productionList.count-1){
                    historyMonthDetails.append(production)
                } else if index == productionList.count-1 || monthName != nameOfMonth{
                    if index == productionList.count-1{
                        historyMonthDetails.append(production)
                    }
                    historyDatas.append(
                    HistoryData(historyMonth: monthName,
                                historyDetails: historyMonthDetails)
                    )
                    historyMonthDetails = []
                    historyMonthDetails.append(production)
                    
                }
                monthName = nameOfMonth
                
//                historyMonthDetails.append(production)
            }
            
            print("historyData", historyDatas.count)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(productionLabel: String, productionDate: Date, productionNotes: String, isProduce: Bool, productionQty: Int32, product_id: UUID, itemType: String) {
        let production = DataProduction(context: viewContext)
        production.id = UUID()
        production.label = productionLabel
        production.date = productionDate
        production.notes = productionNotes
        production.isProduce = isProduce
        production.qty = productionQty
        production.idProduct = product_id
        production.itemType = itemType
//        company.id = UUID()
//        company.title = companyTitle
//        company.owner = companyOwner

        save()
        self.fetchProductionData()
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
