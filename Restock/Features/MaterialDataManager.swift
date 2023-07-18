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
    @Published var searchText: String = "" {
        didSet{
            fetchMaterialData()
        }
    }
    
    @Published var urgentMaterial : [DataMaterial] = []
    @Published var safeMaterial : [DataMaterial] = []
    
    init() {
        fetchMaterialData()
    }
    
    func fetchMaterialData() {
        let request = NSFetchRequest<DataMaterial>(entityName: "DataMaterial")
        request.sortDescriptors = [NSSortDescriptor(key: "currentStock", ascending: true)]
        
        do {
            materialList = try viewContext.fetch(request)
            if searchText.isEmpty{
                urgentMaterial =  materialList.filter { material in
                   material.minimalStock > material.currentStock}
                safeMaterial = materialList.filter { material in
                   material.minimalStock <= material.currentStock}
            }else{
//                urgent material filter
                urgentMaterial = urgentMaterial.filter{ material in
                    material.name!.lowercased().contains(searchText.lowercased())
                }
                
//                safe material filter
                safeMaterial = safeMaterial.filter{ material in
                    material.name!.lowercased().contains(searchText.lowercased())
                }
                
            }
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(materialName: String, currentStock: Int32, minimumStock: Int32, isActive: Bool, unit: String, note: String, image: Data, isProduct: Bool)  -> DataMaterial {
        let material = DataMaterial(context: viewContext)
        material.id = UUID()
        material.name = materialName
        material.currentStock = currentStock
        material.minimalStock = minimumStock
        material.isActive = isActive
        material.unit = unit
        material.note = note
        material.image = image
        material.isProduct = isProduct
        
        save()
        self.fetchMaterialData()
        return material
    }
    
    func editDataFromCoreData(material: DataMaterial, materialName: String, minimalStock: Int32, isActive: Bool, note: String, image: Data) {
        material.name = materialName
        material.minimalStock = minimalStock
        material.isActive = isActive
        material.note = note
        material.image = image
        
        save()
        self.fetchMaterialData()
    }
    
    func restockMaterial(material: DataMaterial, currentStock: Int32){
        material.currentStock = currentStock
        
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
