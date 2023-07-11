//
//  LabelDataManager.swift
//  Restock
//
//  Created by Clarissa Angelia on 07/07/23.
//

import Foundation
import CoreData

class LabelDataManager: ObservableObject {
    static let shared = LabelDataManager()
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var labelList:[DataLabel] = []
    
    init() {
        fetchLabelData()
    }
    
    func fetchLabelData() {

        let request = NSFetchRequest<DataLabel>(entityName: "DataLabel")
//        request.sortDescriptors = [NSSortDescriptor(key: "currentStock", ascending: true)]

        do {
            labelList = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(labelName: String) {
        let label = DataLabel(context: viewContext)
        label.id = UUID()
        label.name = labelName
        

        save()
        self.fetchLabelData()
        print(labelList.count)
        
    }

//    func editDataFromCoreData(product: DataProduct, productName: String, currentStock: Int32, isActive: Bool, unit: String, note: String) {
//        product.name = productName
//        product.currentStock = currentStock
//        product.isActive = isActive
//        product.unit = unit
//
//        save()
//        self.fetchProductData()
//    }

//    func deleteProduct(withID id: UUID) {
//        let fetchRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//
//        do {
//            let products = try viewContext.fetch(fetchRequest)
//            if let product = products.first {
//                viewContext.delete(product)
//                save()
//                self.fetchProductData()
//            }
//        } catch {
//            print("Error deleting product: \(error.localizedDescription)")
//        }
//    }


    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
