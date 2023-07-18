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
    @Published var searchText: String = "" {
        didSet {
            fetchProductData()
        }
    }
    
    @Published var urgentProducts: [DataProduct] = []
    
    @Published var safeProducts: [DataProduct] = []
    
    init() {
        fetchProductData()
    }
    
    func fetchProductData() {
        
        let request = NSFetchRequest<DataProduct>(entityName: "DataProduct")
        request.sortDescriptors = [NSSortDescriptor(key: "currentStock", ascending: true)]
        
        
        do {
            productList = try viewContext.fetch(request)
//            fetch urgent Product
            if searchText.isEmpty{
                 urgentProducts =  productList.filter { product in
                    product.minimalStock > product.currentStock}
//            fetch urgent Product
                 safeProducts = productList.filter { product in
                    product.minimalStock <= product.currentStock}
            }else{
//                urgent product filter
                urgentProducts = urgentProducts.filter{ product in
                    product.name!.lowercased().contains(searchText.lowercased())
                }
//                safe product filter
                safeProducts = safeProducts.filter{ product in
                    product.name!.lowercased().contains(searchText.lowercased())
                }
            }

            print("Jumlah prodak", productList.count)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(productName: String, currentStock: Int32, minimumStock: Int32, isActive: Bool, unit: String, image: Data) -> DataProduct {
        let product = DataProduct(context: viewContext)
        product.id = UUID()
        product.name = productName
        product.currentStock = currentStock
        product.minimalStock = minimumStock
        product.isActive = isActive
        product.image = image
        product.unit = unit
        
        
        save()
        self.fetchProductData()
//        print(productList.count)
        return product
    }
    
    func editDataFromCoreData(product: DataProduct, productName: String, minimalStock: Int32, isActive: Bool) {
        product.name = productName
        product.minimalStock = minimalStock
        product.isActive = isActive
        
        save()
        self.fetchProductData()
    }
    
    func produceProduct(product: DataProduct, currentStock: Int32){
        product.currentStock = currentStock
        
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
