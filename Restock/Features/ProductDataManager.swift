//
//  ProductDataManager.swift
//  Restock
//
//  Created by Clarissa Angelia on 27/06/23.
//

import Foundation
import CoreData

class ProductDataManager: ObservableObject {
    static let shared = ProductDataManager()
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var productList:[DataProduct] = []
    
    init() {
        fetchProductData()
    }
    
    func fetchProductData() {
        let request = NSFetchRequest<DataProduct>(entityName: "DataProduct")
        
        do {
            productList = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(productName: String, currentStock: Int32, minimumStock: Int32, isActive: Bool, unit: String) {
        let product = DataProduct(context: viewContext)
        product.id = UUID()
        product.nama = productName
        product.currentStock = currentStock
        product.minimalStock = minimumStock
        product.isActive = isActive
        product.unit = unit
//        company.id = UUID()
//        company.title = companyTitle
//        company.owner = companyOwner
        
        save()
        self.fetchProductData()
        print(productList.count)
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
