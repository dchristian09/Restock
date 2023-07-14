//
//  Product_Add.swift
//  Restock
//
//  Created by David Christian on 22/06/23.
//

import PhotosUI
import SwiftUI


struct Product_Add: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @StateObject var recipeDataManager: RecipeDataManager = RecipeDataManager.shared
    
    @State var pickerData: [DataMaterial] = []
    @State var selectedUnitList:String = "pcs"
    @State var productName: String = ""
    @State var productCurrentStock: String = ""
    @State var productMinimalStock: String = ""
    @State var selectedProductImage: [PhotosPickerItem] = []
    @State var dataProductImage: Data?
    let unitList = ["pcs", "gram", "liter", "ml", "sheet", "bottle"]
    
    //    ALERT CHECKER
    @State private var isDataIncomplete = false
    @State private var isMaterialIncomplete = false
    
    @State var material = ["Bouquet Rose", "Chocolate Bouquet", "Saya suka sama milo dinosaurus"]
    @State var arrayMaterialIngredients: [MaterialIngredients] = []
    //@State var arrayMaterialIngredients2: [DataMaterial] = []
    @State var arrayMaterialn: [String] = []
    @FocusState private var isQtyFocused: Bool
    
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        //icon
                        HStack{
                            Spacer()
                            if let data = dataProductImage, let uiimage = UIImage(data: data){
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 250)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 150, height: 120)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }.padding(.top)
                        
                        //pick photo
                        PhotosPicker(
                            selection: $selectedProductImage,
                            maxSelectionCount: 1,
                            matching: .images
                        ){
                            Text("Add Photo")
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
                                Text("Product Name")
                                TextField("Name", text: $productName)
                                    .keyboardType(.default)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //current stock
                            HStack{
                                Text("Current Stock")
                                TextField("Current Stock", text: $productCurrentStock)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //minimal stock
                            HStack{
                                Text("Minimal Stock")
                                TextField("Minimal Stock", text: $productMinimalStock)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        
                        Section{
                            HStack{
                                Picker("Product Unit", selection: $selectedUnitList){
                                    ForEach (unitList, id: \.self){
                                        Text($0)
                                    }
                                    
                                }.pickerStyle(.menu)
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
                                    
                                    arrayMaterialIngredients.append(MaterialIngredients(data: nil, materialQuantity: ""))
                                    
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
            }
            .navigationBarTitle("Add Product", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add") {
                        //function
                        saveData()
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        
        .alert(isPresented: $isDataIncomplete) {
            if(isMaterialIncomplete){
                //        Material Alert
                return Alert(title: Text("Ingredient Incomplete"), message: Text("Please enter product ingredient."), dismissButton: .default(Text("OK")))
            }else{
                //        Product Data Alert
                return Alert(title: Text("Product Data Incomplete"), message: Text("Please enter product information."), dismissButton: .default(Text("OK")))
            }
            
            
            
            
        }
        
    }
    
    
    func saveData(){
        print(arrayMaterialIngredients.count)
        if(productName.isEmpty || productMinimalStock.isEmpty || productCurrentStock.isEmpty || selectedUnitList.isEmpty){
            isDataIncomplete = true
        }
        
        if(arrayMaterialIngredients.count > 0){
            for materialIngredient in arrayMaterialIngredients {
                if(materialIngredient.data == nil || materialIngredient.materialQuantity.isEmpty){
                    isMaterialIncomplete = true
                    isDataIncomplete = true
                    
                    //if data incomplete, delete product
//                    productDataManager.deleteProduct(withID: newProduct.id!)
                    
                    break
                }
                isMaterialIncomplete = false
                isDataIncomplete = false
            }
//            If all data already completed
            print(recipeDataManager.recipeList.count)
            if !isMaterialIncomplete && !isDataIncomplete{
                let newProduct: DataProduct =  productDataManager.addDataToCoreData(productName: productName, currentStock: Int32(productCurrentStock) ?? 0, minimumStock: Int32(productMinimalStock) ?? 0, isActive: true, unit: selectedUnitList)
                
                for materialIngredient in arrayMaterialIngredients {
                
                        let idProduct : UUID =  newProduct.id!
                        let idMaterial : UUID = materialIngredient.data!.id!
                        let qtyMaterial: Int32 = Int32(materialIngredient.materialQuantity) ?? 0
                        
                        recipeDataManager.addDataToCoreData(idProduct: idProduct, idMaterial: idMaterial, quantity: qtyMaterial)
                        
                    }
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }else{
            //if data incomplete, delete product
//            productDataManager.deleteProduct(withID: newProduct.id!)
            
            isMaterialIncomplete = true
            isDataIncomplete = true
        }
        
    }
    
    
    func fetchPickerData(){
        pickerData = materialDataManager.materialList.filter { material in
            !arrayMaterialIngredients.contains{ $0.data?.name == material.name}
        }
        
    }
    
}



//struct Product_Add_Previews: PreviewProvider {
//    static var previews: some View {
//        Product_Add()
//    }
//}


//struct MaterialIngredients: Identifiable, Equatable {
struct MaterialIngredients : Hashable {
    var data:DataMaterial? = nil
    //var id = UUID()
    //var materialUnit: String
    var materialQuantity: String
}

