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
//                        Image("bouquet")
                        Image(uiImage: UIImage(data: item.image!)!)
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
                            TextField("Label", text: $itemLabel)
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
        
//        Kalau produk di produce
        if stockOption == "Produce"{
//            pengecekan material cukup / nggak
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
//                Kalau cukup
                if !item.isMaterial{
//                    di cek, ini product jg material/ bukan
//                    Kalau BUKAN material juga
                    for recipe in arrayRecipe{
                        let materialData = materialDataManager.materialList.filter{ material in
                            material.id == recipe.idMaterial
                        }
                        
//                        Tiap material di - sesuai resep
                        materialDataManager.restockMaterial(material: materialData.first!, currentStock: materialData.first!.currentStock - (recipe.quantity * Int32(itemAmount)!))
                        
//                        kalau material yg dipake jg berupa product,                               productny jg diminus
                        if materialData.first!.isProduct{
                            let productData = productDataManager.productList.filter{
                                product in
                                product.name == materialData.first!.name && product.isMaterial
                            }
                            
                            productDataManager.produceProduct(product: productData.first!, currentStock: materialData.first!.currentStock)
                            
                            
                        }
//                        di catet di production
                        productionDataManager.addDataToCoreData(productionLabel: "Produce " + item.name!, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: (recipe.quantity * Int32(itemAmount)!), product_id: materialData.first!.id!, itemType: "Material")
                    }
                }else{
//                    Kalau product is also material
                    let material = materialDataManager.materialList.filter{
                        item.name == $0.name
                    }
                    
//                    produce product = material ikut nambah sesuai product
                    materialDataManager.restockMaterial(material: material.first!, currentStock: material.first!.currentStock + Int32(itemAmount)!)
                    
                    productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty:  Int32(itemAmount)!, product_id: material.first!.id!, itemType: "Material")
                    
                }
                
//                Productnya +
                productDataManager.produceProduct(product: item, currentStock: item.currentStock + (Int32(itemAmount)!))
                
//                catat di history
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Product")
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }else{
//            Kalau product reduce
            if !showAlert{
//            Gak mempengaruhi material, product lsg di -
                productDataManager.produceProduct(product: item, currentStock: item.currentStock - (Int32(itemAmount)!))
                
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Product")
                
                if item.isMaterial{
                    
//                    Kalau product jg material, materialnya jg ikut -
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
