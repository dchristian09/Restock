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
    @State var selectedUnitList:String = "pcs"
    @State var materialName: String = ""
    @State var materialCurrentStock: String = ""
    @State var materialMinimalStock: String = ""
    @State var selectedMaterialImage: [PhotosPickerItem] = []
    @State var dataMaterialImage: Data?
    @State var materialNote: String = ""
    let unitList = ["pcs", "gram", "liter", "ml", "sheet", "bottle"]
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
                        
//                        //icon
//                        HStack{
//                            Spacer()
//                            if let data = dataMaterialImage, let uiimage = UIImage(data: data){
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
                                Text("Bouquet Rose")
//                                TextField("Name", text: $materialName)
//                                    .keyboardType(.numberPad)
//                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //minimal stock
                            HStack{
                                Text("3")
//                                TextField("Minimal Stock", text: $materialMinimalStock)
//                                    .keyboardType(.numberPad)
//                                    .multilineTextAlignment(.trailing)
                            }
                            
                            //current stock
                            HStack{
                                Text("1")
//                                TextField("Current Stock", text: $materialCurrentStock)
//                                    .keyboardType(.numberPad)
//                                    .multilineTextAlignment(.trailing)
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
                            TextField("Notes", text: $materialNote)
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
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Material_Edit_Previews: PreviewProvider {
    static var previews: some View {
        Material_Edit()
    }
}
