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
        request.sortDescriptors = [NSSortDescriptor(key: "currentStock", ascending: true)]
        
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
    
    func editDataFromCoreData(product: DataProduct, productName: String, minimalStock: Int32, isActive: Bool) {
        product.name = productName
        product.minimalStock = minimalStock
        product.isActive = isActive
        
        save()
        self.fetchProductData()
    }
    
    func deleteProduct(withID id: UUID) {
        let fetchRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let products = try viewContext.fetch(fetchRequest)
            if let product = products.first {
                viewContext.delete(product)
                save()
                self.fetchProductData()
            }
        } catch {
            print("Error deleting product: \(error.localizedDescription)")
        }
    }
    
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
