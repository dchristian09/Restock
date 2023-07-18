//
//  Material_Add.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI
import PhotosUI

struct Material_Add: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedUnitList:String = "pcs"
    @State var materialName: String = ""
    @State var materialCurrentStock: String = ""
    @State var materialMinimalStock: String = ""
    @State var materialNote: String = ""
    @State var isAlsoProduct = false
    @State var selectedProductImage: [PhotosPickerItem] = []
    @State var dataProductImage: Data?
    let unitList = ["pcs", "gram", "liter", "ml", "sheet", "bottle"]
    let product = ["Bouquet Rose", "Chocolate Bouquet", "Saya suka sama milo dinosaurus"]
    
    @StateObject var materialDataManager:MaterialDataManager = MaterialDataManager.shared
    @StateObject var productDataManager:ProductDataManager = ProductDataManager.shared
    @StateObject var recipeDataManager:RecipeDataManager = RecipeDataManager.shared
    
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
                            }else{
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 150, height: 120).foregroundColor(.gray)
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
                                Text("Material Name")
                                TextField("Name", text: $materialName)
                                    .keyboardType(.default)
                                    .multilineTextAlignment(.trailing)
                            }
      
                            //current stock
                            HStack{
                                Text("Current Stock")
                                TextField("Current Stock", text: $materialCurrentStock)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //minimal stock
                            HStack{
                                Text("Minimal Stock")
                                TextField("Minimal Stock", text: $materialMinimalStock)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        
                        Section{
                            HStack{
                                Picker("Material Unit", selection: $selectedUnitList){
                                    ForEach (unitList, id: \.self){
                                        Text($0)
                                    }
                                    
                                }.pickerStyle(.menu)
                            }
                        }
                        
                        Section{
                            TextField("Note", text: $materialNote)
                            
                        }
                        
                        HStack {
                            Toggle("Also Add to Product", isOn: $isAlsoProduct)
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Add Material", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add") {
                        saveData()
                        self.presentationMode.wrappedValue.dismiss()
                        //function
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func saveData(){
        var material = materialDataManager.addDataToCoreData(materialName: materialName, currentStock: Int32(materialCurrentStock) ?? 0, minimumStock: Int32(materialMinimalStock) ?? 0, isActive: true, unit: selectedUnitList, note: materialNote, image: dataProductImage!)
        
        if isAlsoProduct{
            var newProduct = productDataManager.addDataToCoreData(productName: materialName, currentStock: Int32(materialCurrentStock) ?? 0, minimumStock: Int32(materialMinimalStock) ?? 0, isActive: true, unit: selectedUnitList, image: dataProductImage!)
            
            recipeDataManager.addDataToCoreData(idProduct: newProduct.id!, idMaterial: material.id!, quantity: 1)
            
        }
        
    }
}

struct Material_Add_Previews: PreviewProvider {
    static var previews: some View {
        Material_Add()
    }
}
