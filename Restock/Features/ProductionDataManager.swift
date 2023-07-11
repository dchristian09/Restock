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
    
    init() {
        fetchProductionData()
    }
    
    func fetchProductionData() {
        let request = NSFetchRequest<DataProduction>(entityName: "DataProduction")
        
        do {
            productionList = try viewContext.fetch(request)
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
