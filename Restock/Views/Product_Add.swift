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
    
    @State var selectedUnitList:String = "pcs"
    @State var productName: String = ""
    @State var productCurrentStock: String = ""
    @State var productMinimalStock: String = ""
    @State var selectedProductImage: [PhotosPickerItem] = []
    @State var dataProductImage: Data?
    let unitList = ["pcs", "gram", "liter", "ml", "sheet", "bottle"]
   
    @State var material = ["Bouquet Rose", "Chocolate Bouquet", "Saya suka sama milo dinosaurus"]
    @State var arrayMaterialIngredients: [MaterialIngredients] = []
    
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        
                        //icon
                        HStack{
                            Spacer()
                            if let data = dataProductImage, let uiimage = UIImage(data: data){
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                            }else{
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 150, height: 120)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        
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
                            
                            //current stock
                            HStack{
                                Text("Current Stock")
                                TextField("Current Stock", text: $productCurrentStock)
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
                                    Menu{
                                        Picker("Materials", selection: $arrayMaterialIngredients[index].materialUnit){
                                            ForEach (materialDataManager.materialList, id: \.self){ material in
                                                Text(material.name ?? "You are short of material")
                                                    .fixedSize(horizontal: true, vertical: true)
                                                    .frame(maxWidth:100,maxHeight:30)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .background(.gray)
                                                    .allowsTightening(false)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .lineLimit(nil)
                                        .truncationMode(.head)
                                        .fixedSize(horizontal: true, vertical: true)
                                        .frame(maxWidth: 100,maxHeight:50)
                                        .labelsHidden()
                                    }label:{
                                        if arrayMaterialIngredients[index].materialUnit == "" {
                                            Text("Choose")
                                                .frame(maxWidth:100,maxHeight:30)
                                        }else{
                                            Text("\(arrayMaterialIngredients[index].materialUnit)")
                                                .frame(maxWidth:100,maxHeight:30)
                                            //                                                .lineLimit(1)
                                            //                                                .truncationMode(.trailing)
                                        }
                                    }
                                    
                                    
                                    Divider()
                                    TextField("Quantity", text: $arrayMaterialIngredients[index].materialQuantity)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.leading)
                                    
                                }
                                
                            }
                            HStack{
                                Button{
                                    arrayMaterialIngredients.append(MaterialIngredients(materialUnit: "", materialQuantity: ""))
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
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
   
    func saveData(){
        productDataManager.addDataToCoreData(productName: productName, currentStock: Int32(productCurrentStock) ?? 0, minimumStock: Int32(productMinimalStock) ?? 0, isActive: true, unit: selectedUnitList)
    }
    
    
}

//func fetchMaterialNames() {
//    materialNames = materialDataManager.materialList.map { $0.name }
//}

struct Product_Add_Previews: PreviewProvider {
    static var previews: some View {
        Product_Add()
    }
}

struct MaterialIngredients: Identifiable, Equatable {
    var id = UUID()
    var materialUnit: String
    var materialQuantity: String
}

