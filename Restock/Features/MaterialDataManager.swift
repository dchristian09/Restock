//
//  MaterialFeatures.swift
//  Restock
//
//  Created by Farid Azhari on 26/06/23.
//

import CoreData
import Foundation

class MaterialDataManager: ObservableObject {
    static let shared = MaterialDataManager()
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var materialList:[DataMaterial] = []
    
    init() {
        fetchMaterialData()
    }
    
    func fetchMaterialData() {
        let request = NSFetchRequest<DataMaterial>(entityName: "DataMaterial")
        
        do {
            materialList = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(materialName: String, currentStock: Int32, minimumStock: Int32, isActive: Bool, unit: String, note: String) {
        let material = DataMaterial(context: viewContext)
        material.id = UUID()
        material.name = materialName
        material.currentStock = currentStock
        material.minimalStock = minimumStock
        material.isActive = isActive
        material.unit = unit
        material.note = note        
        save()
        self.fetchMaterialData()
    }
    
    func editDataFromCoreData(material: DataMaterial, materialName: String, minimalStock: Int32, isActive: Bool, note: String) {
        material.name = materialName
        material.minimalStock = minimalStock
        material.isActive = isActive
        material.note = note
        
        save()
        self.fetchMaterialData()
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
