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
//        request.sortDescriptors = [NSSortDescriptor(key: "currentStock", ascending: true)]
        
        do {
            productList = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(productName: String, currentStock: Int32, minimumStock: Int32, isActive: Bool, unit: String) -> DataProduct {
        let product = DataProduct(context: viewContext)
        product.id = UUID()
        product.name = productName
        product.currentStock = currentStock
        product.minimalStock = minimumStock
        product.isActive = isActive
        product.unit = unit
        
        
        save()
        self.fetchProductData()
        print(productList.count)
        return product
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
