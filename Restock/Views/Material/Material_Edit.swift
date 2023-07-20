//
//  Material_Edit.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI
import PhotosUI

struct Material_Edit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @StateObject var recipeDataManager: RecipeDataManager = RecipeDataManager.shared
    
    @State var selectedUnitList:String = "pcs"
    
//    Accept Variable from Material_Detail
    @Binding var material: DataMaterial
    @State var materialName: String
    @State var materialCurrentStock: Int32
    @State var materialMinimalStock: Int32
    @State var materialNote: String = "-"
    @State var materialUnit: String
    @State var dataMaterialImage: Data
    
//    Save Integer material to String in textfield
    @State var stringMinimalStock: String = ""
    @State var stringCurrentStock: String = ""
    
//picker image variable
    @State var selectedMaterialImage: [PhotosPickerItem] = []
    

    var body: some View {
        let unitList = [materialUnit]
        
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
                           // if let data = dataMaterialImage, let uiimage = UIImage(data: data){
                            if(UIImage(data: dataMaterialImage) != nil) {
                                let uiimage = UIImage(data: dataMaterialImage)
                                Image(uiImage: uiimage!)
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
                        
                        //pick photo
                        PhotosPicker(
                            selection: $selectedMaterialImage,
                            maxSelectionCount: 1,
                            matching: .images
                        ){
                            Text("Edit")
                        }.onChange(of: selectedMaterialImage){ newValue in
                            guard let item = selectedMaterialImage.first else{
                                return
                            }
                            item.loadTransferable(type: Data.self){result in
                                switch result{
                                case.success(let data):
                                    if let data = data {
                                        self.dataMaterialImage = data
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
                                TextField("Name", text: $materialName)
                                    .keyboardType(.default)
                                    .multilineTextAlignment(.trailing)
                                    .onChange(of: materialName) { newValue in
                                        materialName = newValue.isEmpty ? "" : newValue
                                    }
                            }
                            
                            //current stock
                            HStack{
                                Text("Current Stock")
                                TextField("Current Stock", text: $stringCurrentStock)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .disabled(true)
                            }//                  set int as string in textfield
                            .onAppear {
                                stringCurrentStock = String(materialCurrentStock)
                            }
                           

                            
                            //minimal stock
                            HStack{
                                Text("Minimal Stock")
                                    TextField("Minimal Stock", text: $stringMinimalStock)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                            }//                  set int as string in textfield
                            .onAppear {
                                stringMinimalStock = String(materialMinimalStock)
                            }
//                  set new value in variable
                            .onChange(of: stringMinimalStock) { newValue in
                                if let stockValue = Int32(newValue) {
                                    materialMinimalStock = stockValue
                                }
                            }

                        }
                        
                        Section{
                            HStack{
                                Picker("Material Unit", selection: $selectedUnitList){
                                    ForEach (unitList, id: \.self){
                                        Text($0 )
                                    }

                                }.pickerStyle(.menu)
                                    .disabled(true)
                            }
                        }
                        
                        Section{
                            TextField("Notes", text:  $materialNote)
                                .onChange(of: materialNote) { newValue in
                                materialNote = newValue.isEmpty ? "-" : newValue
                            }
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Edit Material", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done") {
                        //function
                        saveEdit()
                    }.disabled(stringMinimalStock.isEmpty || materialName.isEmpty || (dataMaterialImage == nil))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func saveEdit(){
        
        
        if material.isProduct{
            let product = productDataManager.productList.filter{
                $0.name == material.name
            }
            
            productDataManager.editDataFromCoreData(product: product.first!, productName: materialName, minimalStock: materialMinimalStock, isActive: true, image: dataMaterialImage)
        }
        
        materialDataManager.editDataFromCoreData(material: material, materialName: materialName, minimalStock: materialMinimalStock, isActive: true, note: materialNote, image: dataMaterialImage)
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct Material_Edit_Previews: PreviewProvider {
//    static var previews: some View {
//        Material_Edit(materialName: "", materialCurrentStock: 0, materialMinimalStock: 0)
//    }
//}
