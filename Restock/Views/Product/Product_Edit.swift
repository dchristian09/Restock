//
//  Product_Edit.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI
import PhotosUI

struct Product_Edit: View {
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @StateObject var recipeDataManager: RecipeDataManager = RecipeDataManager.shared
    
    @State var selectedUnitList:String = "pcs"
    
    //    Variable from Product_Detail
    @Binding var product: DataProduct
    @State var productName: String
    @State var productCurrentStock: Int32
    @State var productMinimalStock: Int32
    @State var productUnit: String
    
    //    Save Integer material to string
    @State var stringMinimalStock: String = ""
    @State var stringCurrentStock: String = ""
    
    @State var selectedProductImage: [PhotosPickerItem] = []
    @State var dataProductImage: Data?
    
    //    ALERT CHECKER
    @State private var isDataIncomplete = false
    @State private var isMaterialIncomplete = false
    
    //    Product Array Ingredient (new for edited ingredients, old for comparison.)
    @State var arrayMaterialIngredients: [MaterialIngredients] = []
    @State var oldArrayMaterialIngredients: [MaterialIngredients] = []
    
    //    variable for picker
    @State var pickerData: [DataMaterial] = []
    
    @Binding var toPreviousPage:Bool
    
    var body: some View {
        let unitList = [productUnit]
        //        NavigationView{
        ZStack {
            Rectangle()
                .fill(Color(hex: 0xf2f4ff))
                .ignoresSafeArea()
            VStack{
                VStack {
                    
                    HStack{
                        Spacer()
                        if let data = dataProductImage, let uiimage = UIImage(data: data){
                            Image(uiImage: uiimage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 250)
                        }else{
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 180, height: 180)
                        }
                        Spacer()
                    }
//                    Button("assa"){
//                        self.toPreviousPage = false
//                    }
                    //edit photo
                    PhotosPicker(
                        selection: $selectedProductImage,
                        maxSelectionCount: 1,
                        matching: .images
                    ){
                        Text("Edit")
                    }.onChange(of: selectedProductImage){ newValue in
                        guard let item = selectedProductImage.first else{
                            return
                        }
                        item.loadTransferable(type: Data.self){result in
                            switch result{
                            case.success(let data):
                                if let data = data {
                                    self.dataProductImage = data
                                }else{
                                    print("Data is nil")
                                }
                            case.failure(let failure):
                                fatalError("\(failure)")
                            }
                        }
                    }
                    
                }
                
                Form {
                    Section{
                        //product
                        HStack{
                            Text("Name")
                            TextField("Name", text: $productName)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                                .onChange(of: productName) { newValue in
                                    productName = newValue.isEmpty ? "" : newValue
                                }
                        }
                        
                        //current stock
                        HStack{
                            Text("Current Stock").foregroundColor(.gray)
                            TextField("Current Stock", text: $stringCurrentStock)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                        }//                  set int as string in textfield
                        .onAppear {
                            stringCurrentStock = String(productCurrentStock)
                        }
                        
                        //minimal stock
                        HStack{
                            Text("Minimal Stock")
                            TextField("Minimal Stock", text: $stringMinimalStock)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        //set int as string in textfield
                        .onAppear {
                            stringMinimalStock = String(productMinimalStock)
                        }
                        //set new value in variable
                        .onChange(of: stringMinimalStock) { newValue in
                            if let stockValue = Int32(newValue) {
                                productMinimalStock = stockValue
                            }
                        }
                    }
                    
                    Section{
                        HStack{
                            Picker("Product Unit", selection: $selectedUnitList){
                                ForEach (unitList, id: \.self){
                                    Text($0)
                                }
                                
                            }.pickerStyle(.menu)
                                .disabled(true)
                        }
                    }
                    
                    Section{
                        ForEach(arrayMaterialIngredients.indices, id:\.self) { index in
                            HStack{
                                Button(action: {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                    arrayMaterialIngredients.remove(at: index)
                                }){
                                    HStack {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                                Menu{
                                    if(pickerData.count > 0){
                                        Picker("Materials", selection: $arrayMaterialIngredients[index].data){
                                            
                                            ForEach (pickerData, id: \.id){ material in
                                                Text(material.name ?? "You are short of material")
                                                    .fixedSize(horizontal: true, vertical: true)
                                                    .frame(maxWidth:75,maxHeight:30)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .background(.gray)
                                                    .allowsTightening(false)
                                                    .tag(material as DataMaterial?)
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        .pickerStyle(.menu)
                                        .lineLimit(nil)
                                        .truncationMode(.head)
                                        .fixedSize(horizontal: true, vertical: true)
                                        .frame(maxWidth: 75,maxHeight:30)
                                        .labelsHidden()
                                        
                                    }else{
                                        Text("You have no more Material")
                                    }
                                }label:{
                                    if arrayMaterialIngredients[index].data == nil {
                                        Text("Choose")
                                            .frame(maxWidth:75,maxHeight:30)
                                    }else{
                                        Text("\(arrayMaterialIngredients[index].data?.name ?? "")")
                                            .frame(maxWidth:75,maxHeight:30)
                                    }
                                }.onAppear{
                                    fetchPickerData()
                                }
                                
                                Divider()
                                TextField("Quantity", text: $arrayMaterialIngredients[index].materialQuantity)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if arrayMaterialIngredients[index].data == nil {
                                    Text("Unit")
                                }else{
                                    Text("\(arrayMaterialIngredients[index].data?.unit ?? "")")
                                }
                            }
                            
                        }
                        HStack{
                            Button{
                                
                                arrayMaterialIngredients.append(MaterialIngredients(data:nil, materialQuantity: ""))
                                
                            }label:{
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                    Text("add material")
                                        .foregroundColor(.black)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
            }
            .alert(isPresented: $isDataIncomplete) {
                if(isMaterialIncomplete){
                    //        Material Alert
                    return Alert(title: Text("Ingredient Incomplete"), message: Text("Please enter product ingredient."), dismissButton: .default(Text("OK")))
                }else{
                    //        Product Data Alert
                    return Alert(title: Text("Product Data Incomplete"), message: Text("Please enter product information."), dismissButton: .default(Text("OK")))
                }
                
            }
        }.onAppear{
            print("Appear Edit")
            getRecipe()
            fetchPickerData()
        }
        
        
        
        //        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Edit Product", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Cancel") {
//                        cancelEdit()
                    self.toPreviousPage = false
//                        self.presentationMode.wrappedValue.dismiss()
                    
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done") {
                    //function
//                    saveEdit()
                    self.toPreviousPage = false
                    print("inDone: ", toPreviousPage)
                }
            }
        }
        
    }
    
    func getRecipe(){
        //        print("Asli arrRecipeCount: ",recipeDataManager.recipeList.count)
        //        print("Id",product.id)
        //
        //        print("Iterasi Resep")
        
        //        for i in recipeDataManager.recipeList{
        //            print(i.idProduct)
        //        }
        //
        //        print("End Iterasi Resep")
        let arrayRecipe = recipeDataManager.recipeList.filter { recipe in
            recipe.idProduct ==  product.id
            
        }
        
        //        print("arrRecipeCount: ",arrayRecipe.count)
        
        for recipe in arrayRecipe{
            let materialData = materialDataManager.materialList.filter{
                $0.id == recipe.idMaterial
            }
            arrayMaterialIngredients.append(MaterialIngredients(data: materialData[0], materialQuantity: String(recipe.quantity)))
            oldArrayMaterialIngredients.append(MaterialIngredients(data: materialData[0], materialQuantity: String(recipe.quantity)))
            
            recipeDataManager.deleteData(recipe: recipe)
            
        }
        
        //        print("arrMaterialIngCount: ", arrayMaterialIngredients.count)
        
    }
    
    func cancelEdit(){
        print("inCancelEdit : ",self.toPreviousPage)
        print("inCancelEdit Count : ",self.oldArrayMaterialIngredients.count)
        for materialIngredient in oldArrayMaterialIngredients {
            let idProduct : UUID =  product.id!
            let idMaterial : UUID = materialIngredient.data!.id!
            let qtyMaterial: Int32 = Int32(materialIngredient.materialQuantity) ?? 0
            
            recipeDataManager.addDataToCoreData(idProduct: idProduct, idMaterial: idMaterial, quantity: qtyMaterial)
            
        }
        self.toPreviousPage = false
        
        print("Check me previous",self.toPreviousPage)
    }
    
    func saveEdit(){
        if(productName.isEmpty || stringMinimalStock.isEmpty){
            isDataIncomplete = true
        }
        
        productDataManager.editDataFromCoreData(product: product, productName: productName, minimalStock: productMinimalStock, isActive: true)
        
        if(arrayMaterialIngredients.count > 0){
            for materialIngredient in arrayMaterialIngredients {
                if(materialIngredient.data == nil || materialIngredient.materialQuantity.isEmpty){
                    isMaterialIncomplete = true
                    isDataIncomplete = true
                    
                    //if data incomplete, delete product
                    cancelEdit()
                    return
                }
                isMaterialIncomplete = false
                isDataIncomplete = false
            }
            
            //            If all data already completed
            if !isMaterialIncomplete && !isDataIncomplete{
                for materialIngredient in arrayMaterialIngredients {
                    
                    let idProduct : UUID =  product.id!
                    let idMaterial : UUID = materialIngredient.data!.id!
                    let qtyMaterial: Int32 = Int32(materialIngredient.materialQuantity) ?? 0
                    
                    recipeDataManager.addDataToCoreData(idProduct: idProduct, idMaterial: idMaterial, quantity: qtyMaterial)
                    
                    
                }
                //                print("Sha Sha", recipeDataManager.recipeList.count)
                //                self.presentationMode.wrappedValue.dismiss()
                self.toPreviousPage = false
            }
            
        }else{
            isMaterialIncomplete = true
            isDataIncomplete = true
            //            self.presentationMode.wrappedValue.dismiss()
            
            self.toPreviousPage = false
        }
        
    }
    
    func fetchPickerData(){
        pickerData = materialDataManager.materialList.filter { material in
            !arrayMaterialIngredients.contains{ $0.data?.name == material.name}
        }
        
    }
    
}

//struct Product_Edit_Previews: PreviewProvider {
//    static var previews: some View {
//        Product_Edit()
//    }
//}
