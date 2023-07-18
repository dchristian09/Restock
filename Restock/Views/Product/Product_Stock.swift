//
//  Product_Stock.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

import SwiftUI

struct Product_Stock: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @StateObject var recipeDataManager: RecipeDataManager = RecipeDataManager.shared
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var productionDataManager: ProductionDataManager = ProductionDataManager.shared
    @StateObject var labelDataManager: LabelDataManager = LabelDataManager.shared
    
    @State var item : DataProduct
    @State private var itemAmount: String = ""
    @State private var itemNote: String = ""
    @State private var itemLabel: String = ""
    @State private var itemDate = Date.now
    
    @State var showAlert : Bool = false
    var stockOption:String = ""
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack {
                        //image
                        Image("bouquet")
                            .resizable()
                            .cornerRadius(16)
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                            .padding(.top)
                        //text
                        Text(item.name!)
                            .font(.largeTitle)
                    }
                    Form {
                        HStack{
                            Text((stockOption)+" Amount")
                            TextField("Amount", text: $itemAmount)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text((stockOption)+" Date")
                            DatePicker(selection: $itemDate, in: ...Date.now, displayedComponents: .date) {
                                
                            }
                        }
                        HStack{
                            Text((stockOption)+" Label")
                            TextField("Amount", text: $itemLabel)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                        }
                        TextField((stockOption)+" Notes", text: $itemNote)
                            .keyboardType(.default)
                    }
                }
            }
            .navigationBarTitle((stockOption), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    //                    if selectedTheme == "Produce Stock"{
                    //                        Button("Restock") {
                    //                            //function
                    //                        }
                    //                    }else{
                    //                        Button("Reduce") {
                    //                            //function
                    //                        }
                    //                    }
                    Button(stockOption) {
                        //function
                        Production()
                    }.disabled(itemAmount == "" && itemLabel == "")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert){
            return Alert(title: Text("Lacking Raw Material"), message: Text("Please restock your material first"), dismissButton: .default(Text("OK")))
        }
    }
    
    func Production(){
        let arrayRecipe = recipeDataManager.recipeList.filter { recipe in
            recipe.idProduct ==  item.id
        }
        
        if stockOption == "Produce"{
            for recipe in arrayRecipe{
                let materialData = materialDataManager.materialList.filter{ material in
                    material.id == recipe.idMaterial
                }
                if recipe.quantity * Int32(itemAmount)! > materialData.first!.currentStock {
                    showAlert = true
                    break
                }
                showAlert = false
            }
            
            if !showAlert{
                if !item.isMaterial{
                    for recipe in arrayRecipe{
                        let materialData = materialDataManager.materialList.filter{ material in
                            material.id == recipe.idMaterial
                        }
                        
                        materialDataManager.restockMaterial(material: materialData.first!, currentStock: materialData.first!.currentStock - (recipe.quantity * Int32(itemAmount)!))
                        
                        productionDataManager.addDataToCoreData(productionLabel: "Produce " + item.name!, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: (recipe.quantity * Int32(itemAmount)!), product_id: materialData.first!.id!, itemType: "Material")
                    }
                }else{
                    let material = materialDataManager.materialList.filter{
                        item.name == $0.name
                    }
                    
                    materialDataManager.restockMaterial(material: material.first!, currentStock: material.first!.currentStock + Int32(itemAmount)!)
                    
                    productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty:  Int32(itemAmount)!, product_id: material.first!.id!, itemType: "Material")
                    
                }
                productDataManager.produceProduct(product: item, currentStock: item.currentStock + (Int32(itemAmount)!))
                
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Product")
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }else{
            if !showAlert{
                productDataManager.produceProduct(product: item, currentStock: item.currentStock - (Int32(itemAmount)!))
                
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Product")
                
                if item.isMaterial{
                    let material = materialDataManager.materialList.filter{
                        $0.name == item.name
                    }
                    
                    materialDataManager.restockMaterial(material: material.first!, currentStock: material.first!.currentStock - Int32(itemAmount)!)
                    
                    productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: Int32(itemAmount)!, product_id: material.first!.id!, itemType: "Material")
                }
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

//struct Product_Stock_Previews: PreviewProvider {
//    static var previews: some View {
//        Product_Stock()
//    }
//}
