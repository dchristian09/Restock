//
//  Product_Edit.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI
import PhotosUI

struct Product_Edit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedUnitList:String = "pcs"
    @State var productName: String = ""
    @State var productCurrentStock: String = ""
    @State var productMinimalStock: String = ""
    @State var selectedProductImage: [PhotosPickerItem] = []
    @State var dataProductImage: Data?
    let unitList = ["pcs", "gram", "liter", "ml", "sheet", "bottle"]
    let product = ["Bouquet Rose", "Chocolate Bouquet"]
    @State var arrayMaterialIngredients: [MaterialIngredients] = []
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        Image("bouquet")
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 150, height: 150)
                            .padding(.top)
                        
                        //icon
                        //                        HStack{
                        //                            Spacer()
                        //                            if let data = dataProductImage, let uiimage = UIImage(data: data){
                        //                                Image(uiImage: uiimage)
                        //                                    .resizable()
                        //                                    .frame(width: 180, height: 180)
                        //                            }else{
                        //                                Image(systemName: "photo")
                        //                                    .resizable()
                        //                                    .frame(width: 180, height: 180)
                        //                            }
                        //                            Spacer()
                        //                        }
                        
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
                                Text("Bouquet Rose")
                                //                                TextField("Name", text: $productName)
                                //                                    .keyboardType(.numberPad)
                                //                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //current stock
                            HStack{
                                Text("1").foregroundColor(.gray)
                                //                                TextField("Current Stock", text: $productCurrentStock)
                                //                                    .keyboardType(.numberPad)
                                //                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //minimal stock
                            HStack{
                                Text("3")
                                //                                TextField("Minimal Stock", text: $productMinimalStock)
                                //                                    .keyboardType(.numberPad)
                                //                                    .multilineTextAlignment(.trailing)
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
                                    Picker("a", selection: $arrayMaterialIngredients[index].materialUnit){
                                        ForEach (product, id: \.self){
                                            Text($0)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .labelsHidden()
                                    .frame(maxWidth: 100)
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
            .navigationBarTitle("Edit Product", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done") {
                        //function
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Product_Edit_Previews: PreviewProvider {
    static var previews: some View {
        Product_Edit()
    }
}
