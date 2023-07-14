//
//  Production_Stock.swift
//  Restock
//
//  Created by David Christian on 15/06/23.
//

import SwiftUI
import PhotosUI

struct Production_Stock: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedTheme:String = "Produce Stock"
    @State var selectedProduct:String = "Bouquet Rose"
    @State var selectedProductLabel:String = "Chocolate Bouquet"
    @State private var itemNumber: String = ""
    @State private var itemNote: String = ""
    @State private var customLabel: String = ""
    @State private var itemDate = Date.now
    @State var selectedProduceItems: [PhotosPickerItem] = []
    @State var selectedReduceItems: [PhotosPickerItem] = []
    @State var dataProduce: Data?
    @State var dataReduce: Data?
    let themes = ["Produce Stock", "Reduce Stock"]
    let product = ["Bouquet Rose", "Chocolate Bouquet"]
    let label = ["Event", "Cadangan"]
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Picker("Appearance", selection: $selectedTheme) {
                            ForEach(themes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        Spacer()
                    }.padding(.all)
                    
                    if selectedTheme == "Produce Stock"{
                        VStack {
                            HStack{
                                Spacer()
                                if let data = dataProduce, let uiimage = UIImage(data: data){
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .frame(width: 150, height: 120)
                                }else{
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 150, height: 120)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }.padding(.top)
                            PhotosPicker(
                                selection: $selectedProduceItems,
                                maxSelectionCount: 1,
                                matching: .images
                            ){
                                Text("Add Photo")
                            }.onChange(of: selectedProduceItems){ newValue in
                                guard let item = selectedProduceItems.first else{
                                    return
                                }
                                item.loadTransferable(type: Data.self){result in
                                    switch result{
                                    case.success(let data):
                                        if let data = data {
                                            self.dataProduce = data
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
                            Picker("Product", selection: $selectedProduct){
                                ForEach (product, id: \.self){
                                    Text($0)
                                }
                                
                            }.pickerStyle(.navigationLink)
                            HStack{
                                Text("Product Amount")
                                TextField("Amount", text: $itemNumber)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack{
                                Text("Produce Date")
                                DatePicker(selection: $itemDate, in: ...Date.now, displayedComponents: .date) {
                                    
                                }
                            }
                            HStack{
                                Picker("Produce Label", selection: $selectedProductLabel){
                                    ForEach (label, id: \.self){
                                        Text($0)
                                    }
                                    TextField("Custom Label", text: $customLabel)
                                        .keyboardType(.default)
                                }.pickerStyle(.navigationLink)
                            }
                            TextField("Notes", text: $itemNote)
                                .keyboardType(.default)
                        }
                        
                    }else{
                        VStack {
                            HStack{
                                Spacer()
                                if let data = dataReduce, let uiimage = UIImage(data: data){
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .frame(width: 150, height: 120)
                                }else{
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 150, height: 120)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }.padding(.top)
                            PhotosPicker(
                                selection: $selectedReduceItems,
                                maxSelectionCount: 1,
                                matching: .images
                            ){
                                Text("Add Photo")
                            }.onChange(of: selectedReduceItems){ newValue in
                                guard let item = selectedReduceItems.first else{
                                    return
                                }
                                item.loadTransferable(type: Data.self){result in
                                    switch result{
                                    case.success(let data):
                                        if let data = data {
                                            self.dataReduce = data
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
                            Picker("Product", selection: $selectedProduct){
                                ForEach (product, id: \.self){
                                    Text($0)
                                }
                                
                            }.pickerStyle(.navigationLink)
                            HStack{
                                Text("Product Amount")
                                TextField("Amount", text: $itemNumber)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            HStack{
                                Text("Reduce Date")
                                DatePicker(selection: $itemDate, in: ...Date.now, displayedComponents: .date) {
                                    
                                }
                            }
                            HStack{
                                Picker("Reduce Label", selection: $selectedProductLabel){
                                    ForEach (product, id: \.self){
                                        Text($0)
                                    }
                                    
                                }.pickerStyle(.navigationLink)
                            }
                            TextField("Notes", text: $itemNote)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                    
                    
                }
                
            }
            .navigationBarTitle("Production", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    if selectedTheme == "Produce Stock"{
                        Button("Produce") {
                            //function
                        }
                    }else{
                        Button("Reduce") {
                            //function
                        }
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Production_Stock_Previews: PreviewProvider {
    static var previews: some View {
        Production_Stock()
    }
}
