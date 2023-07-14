//
//  Material.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI
import PhotosUI

struct Material: View {
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var showingAlert: Bool = false
    @State var showingSheet: Bool = false
    
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    
    //    @State var materialDataManager.urgentMaterials: [DataMaterial] = []
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 50, style:.continuous)
                    .fill(.white)
                    .frame(maxHeight: .greatestFiniteMagnitude)
                
                ScrollView {
                    ZStack{
                        
                        
                        //there is material
                        if(materialDataManager.materialList.count > 0 ){
                            VStack{
                                //low stock material
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Low Stock Material")
                                        .font(.title2.bold())
                                    Spacer()
                                    
                                    if materialDataManager.urgentMaterial.count > 4 {
                                        NavigationLink {
                                            Material_Reminder()
                                        } label: {
                                            Text("View More " + String(materialDataManager.urgentMaterial.count))
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }.padding()
                                //material card
                                if materialDataManager.urgentMaterial.count > 0 {
                                    LazyVGrid(columns: columns){
                                        ForEach(materialDataManager.urgentMaterial.indices,id:\.self){ index in
                                            NavigationLink{
                                                Material_Detail(material: $materialDataManager.urgentMaterial[index])
                                            }label: {
                                                Main_Card_View(materialName:materialDataManager.urgentMaterial[index].name ?? "", materialUnit: materialDataManager.urgentMaterial[index].unit ?? "", materialStock: materialDataManager.urgentMaterial[index].currentStock, materialMinStock: materialDataManager.urgentMaterial[index].minimalStock)
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                }else if materialDataManager.urgentMaterial.isEmpty && materialDataManager.searchText.isEmpty{
                                    //Low Stock empty state
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("Yay!  All your material at a safe level~")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                }else if materialDataManager.urgentMaterial.isEmpty && !materialDataManager.searchText.isEmpty{
                                    //Low Stock empty state on search
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("No Material Match")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                }
                                // safe material
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Safe Material")
                                        .font(.title2.bold())
                                    Spacer()
                                }.padding()
                                //material card
                                if !materialDataManager.safeMaterial.isEmpty{
                                    LazyVGrid(columns: columns){
                                        ForEach(materialDataManager.safeMaterial.indices,id:\.self){ index in
                                            NavigationLink{
                                                Material_Detail(material: $materialDataManager.safeMaterial[index])
                                            }label: {
                                                Main_Card_View(materialName:materialDataManager.safeMaterial[index].name ?? "", materialUnit: materialDataManager.safeMaterial[index].unit ?? "", materialStock: materialDataManager.safeMaterial[index].currentStock, materialMinStock: materialDataManager.safeMaterial[index].minimalStock)
                                            }
                                        }
                                    }
                                } else if materialDataManager.safeMaterial.isEmpty && materialDataManager.searchText.isEmpty{
                                    //Low Stock empty state on search
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("No Safe Material")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                } else if materialDataManager.safeMaterial.isEmpty && !materialDataManager.searchText.isEmpty{
                                    //Low Stock empty state on search
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("No Material Match")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                }

                                Spacer()
                            }
                            .padding()
                            //no material
                        } else {
                            Material_No_Data()
                        }
                        //                            VStack {
                        //                                Text("There is no material yet.")
                        //                                    .font(.system(size: 22))
                        //                                    .foregroundColor(Color(hex: 0x8E8E93))
                        //
                        //                                HStack {
                        //                                    Text("Please tap")
                        //                                        .font(.system(size: 22))
                        //                                        .foregroundColor(Color(hex: 0x8E8E93))
                        //                                    Image(systemName: "plus")
                        //                                        .font(.system(size: 22))
                        //                                        .foregroundColor(.blue)
                        //                                    Text("to add your material")
                        //                                        .font(.system(size: 22))
                        //                                        .foregroundColor(Color(hex: 0x8E8E93))
                        //                                }
                        //
                        //                                Image("material_no_data")
                        //                                    .resizable()
                        //                                    .frame(width: 393, height: 256)
                        //
                        //                                Image("material_no_data_wave")
                        //                                    .resizable()
                        //                                    .frame(width: 393, height: 104)
                        //                                    .offset(y: 65)
                        //                            }.padding()
                        //                        }
                    }
                }
            }
            //            .onAppear{
            //                getUrgentStock()
            //            }
            .navigationBarTitle("Material")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $materialDataManager.searchText)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        if(materialDataManager.materialList.count > 0 ){
                            Button {
                                withAnimation {
                                    showingSheet = true
                                }
                            }label: {
                                Image(systemName: "info.circle")
                            }.sheet(isPresented: $showingSheet){
                                Indicator_Modal_View(showSheetView: $showingSheet)
                            }
                        }
                        NavigationLink {
                            Material_Add()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }

//    func getUrgentStock(){
//        materialDataManager.urgentMaterials = materialDataManager.materialList.filter { material in
//            material.minimalStock > material.currentStock
//        }
//    }
}

//struct Material_Previews: PreviewProvider {
//    static var previews: some View {
//        Material()
//    }
//}
