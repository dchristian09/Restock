//
//  Product_Detail.swift
//  Restock
//
//  Created by David Christian on 22/06/23.
//

import SwiftUI

struct Product_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var product: DataProduct
    
    @StateObject var recipeDataManager : RecipeDataManager = RecipeDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @State var productMaterial : [ProductRecipe] = []
    @State var pindah = false
    var body: some View {
        
        let productName: String = $product.wrappedValue.name ?? ""
        let productCurrentStock: Int32 = $product.wrappedValue.currentStock
        let productMinimalStock: Int32 = $product.wrappedValue.minimalStock
        let productUnit: String = $product.wrappedValue.unit ?? ""
        let productImage : Data = $product.wrappedValue.image!
        
//        NavigationView{
            ZStack {
                
                
//                NavigationLink{
//                    Product_Edit(recipeDataManager: recipeDataManager, product: $product, productName: productName, productCurrentStock: productCurrentStock, productMinimalStock: productMinimalStock, productUnit: productUnit, toPreviousPage: $pindah)
//                }label: {
//                    EmptyView()
//                }
                
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    //image
                    Image(uiImage: UIImage(data: productImage)!)
                        .resizable()
                        .cornerRadius(16)
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                        .padding(.top)
                    //text
                    Text(productName)
                        .font(.largeTitle)
                    //button
                    HStack{
                        NavigationLink{
                            Product_Stock(item: product, stockOption: "Produce")
                        }label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Produce") // 2
                            }.padding(15)
                                .foregroundColor(.white)
                                .background(.green)
                                .cornerRadius(8)
                            
                        }
                        NavigationLink{
                            Product_Stock(item: product, stockOption: "Reduce")
                        }label: {
                            HStack {
                                Image(systemName: "minus.circle")
                                Text("Reduce") // 2
                            }.padding(15)
                                .foregroundColor(Color(hex: 0xff605c))
                                .background(.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: 0xff605c))
                                )
                        }
                    }
                    VStack{
                        List {
                            //stock section
                            Section(header: Text("Stock")){
                                HStack {
                                    Text("Current Stock")
                                    Spacer()
                                    Text(String(productCurrentStock) + " " + (productUnit))
                                }
                                HStack {
                                    Text("Minimal Stock")
                                    Spacer()
                                    Text(String(productMinimalStock) + " " + (productUnit))
                                }
                            }
                            //materials section
                            Section(header: Text("Materials")){
                                ForEach(productMaterial, id: \.self){ material in
                                    HStack {
                                        Text(material.materialName)
                                        Spacer()
                                        Text(String(material.quantity) + " " + material.unit)
                                    }
                                }
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                    Spacer()
                }
                
//            }
            .navigationBarTitle("Product Detail", displayMode: .inline)
        
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back") // 2
                        }
                    })
                }
               
                
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: Product_Edit(recipeDataManager: recipeDataManager, product: $product, productName: productName, productCurrentStock: productCurrentStock, productMinimalStock: productMinimalStock, productUnit: productUnit, toPreviousPage: $pindah)) {
                        Text("Edit")
                    }
                    
                    
                    
                }
                
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button("Sapiman"){
//                        print("Detail Iterasi Resep")
//
//                        recipeDataManager.fetchRecipeData()
                        
//                        for i in recipeDataManager.recipeList{
//                            print(i.idProduct)
//                        }
//
//                        print("End Detail Iterasi Resep")
//                        print("Sapiman", recipeDataManager.recipeList.count)
//                    }
                    
//                }
                
            }.navigationBarBackButtonHidden(true)
            .onAppear{
                print("Appear Detail")
                getRecipe()
            }
        }
        
        func getRecipe(){
//            initial state
            productMaterial = []
            print ("Detail Rece",recipeDataManager.recipeList.count)
//            get recipe
            let arrayRecipe = recipeDataManager.recipeList.filter { recipe in
                recipe.idProduct ==  product.id}
            
            print ("Detail Array Rece",recipeDataManager.recipeList.count)
            
            for recipe in arrayRecipe{
                let materialData = materialDataManager.materialList.filter{
                    $0.id == recipe.idMaterial
                }
                productMaterial.append(ProductRecipe(materialName: materialData[0].name!, unit: materialData[0].unit!, quantity: recipe.quantity))
            }
                
            print(productMaterial.count)
            
        }
    
   
    
}

struct ProductRecipe : Hashable {
    var materialName: String
    var unit: String
    var quantity: Int32
}

//struct Product_Detail_Previews: PreviewProvider {
//    @State static var teamp:DataProduct  = DataProduct()
//    static var previews: some View {
//        Product_Detail(product: $teamp)
//    }
//}
