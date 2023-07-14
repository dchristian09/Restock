//
//  History_card_view.swift
//  Restock
//
//  Created by Farid Azhari on 08/07/23.
//

import SwiftUI

struct History_card_view: View {
    @State var dataProduction:DataProduction
    
    @StateObject var productionDataManager : ProductionDataManager = ProductionDataManager.shared
    @StateObject var materialDataManager : MaterialDataManager = MaterialDataManager.shared
    @StateObject var productDataManager : ProductDataManager = ProductDataManager.shared
    @StateObject var recipeDataManager : RecipeDataManager = RecipeDataManager.shared
    
    @State var showingAlert = false
    var body: some View {
        
            HStack{
                Text("\(Calendar.current.dateComponents([.day], from: dataProduction.date!).day!)")
                    .font(.title).padding(5).fontWeight(.bold).foregroundColor(.gray)
            
            NavigationLink{
                Production_Detail(production: $dataProduction)
            } label:{
                Production_Card_View(dataProduction: dataProduction )
            } .swipeActions() {
                Button("Delete") {
                    showingAlert = true
//                    cancelProduction()
                }.tint(.red)
            }
            .alert("Are you sure to cancel this production?", isPresented: $showingAlert){
                Button("Delete", role: .destructive){ cancelProduction()}
                Button("Cancel", role: .cancel){}
            }
        }
        
    }
    
    func cancelProduction(){
        productionDataManager.softDeleteData(production: dataProduction)
        
        let arrayRecipe = recipeDataManager.recipeList.filter{ recipe in
            recipe.idProduct == dataProduction.idProduct
        }
        
        for recipe in arrayRecipe{
            let materialData = materialDataManager.materialList.filter{ material in
                material.id == recipe.idMaterial
            }
            
            materialDataManager.restockMaterial(material: materialData.first!, currentStock: (recipe.quantity * dataProduction.qty) + materialData.first!.currentStock)
        }
        
        let productData = productDataManager.productList.filter{ product in
            product.id == dataProduction.idProduct
        }
        productDataManager.produceProduct(product: productData.first!, currentStock: productData.first!.currentStock - dataProduction.qty)
        
    }
}

//struct History_card_view_Previews: PreviewProvider {
//    static var previews: some View {
//        History_card_view(historyDetail: HistoryDetail())
//    }
//}
