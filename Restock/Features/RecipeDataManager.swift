//
//  ResepDataManager.swift
//  Restock
//
//  Created by Clarissa Angelia on 03/07/23.
//

import Foundation
import CoreData

class RecipeDataManager: ObservableObject {
    static let shared = RecipeDataManager()
    private let viewContext = PersistenceController.shared.viewContext
    
    @Published var recipeList:[DataRecipe] = []
    
    init() {
        fetchRecipeData()
    }
    
    func fetchRecipeData() {
        let request = NSFetchRequest<DataRecipe>(entityName: "DataRecipe")
        
        do {
            recipeList = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func addDataToCoreData(idProduct: UUID, idMaterial: UUID, quantity: Int32) {
        let recipe = DataRecipe(context: viewContext)
        recipe.id = UUID()
        recipe.idMaterial = idMaterial
        recipe.idProduct = idProduct
        recipe.quantity = quantity
        

        save()
        self.fetchRecipeData()
        print(recipeList)
    }
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
}
