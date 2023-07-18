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
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack{
                        RoundedRectangle(cornerRadius: 50, style:.continuous)
                            .fill(.white)
                            .frame(maxHeight: .infinity)
                        
                        //there is material
                        if(materialDataManager.materialList.count > 0 ){
                            VStack{
                                //low stock material
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Low Stock Material")
                                        .font(.title2.bold())
                                    Spacer()
                                    NavigationLink {
                                        Material_Reminder()
                                    } label: {
                                        Text("View Another")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                    }
                                }.padding()
                                //material card
                                LazyVGrid(columns: columns){
                                    ForEach(materialDataManager.materialList.indices,id:\.self){ index in
                                        NavigationLink{
                                            Material_Detail(material: $materialDataManager.materialList[index])
                                        }label: {
                                            Main_Card_View(materialName:materialDataManager.materialList[index].name ?? "", materialUnit: materialDataManager.materialList[index].unit ?? "", materialStock: materialDataManager.materialList[index].currentStock)
                                                .swipeActions{
                                                    Button("Delete", role: .destructive){
                                                        materialDataManager.materialList.remove(at: index)
                                                    }
                                                }
                                        }
                                        .swipeActions{
                                            Button("Delete", role: .destructive){
                                                materialDataManager.materialList.remove(at: index)
                                            }
                                        }
                                    }
                                    
                                }
                                // safe material
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Safe Material")
                                        .font(.title2.bold())
                                    Spacer()
                                }.padding()
                                //material card
                                LazyVGrid(columns: columns){
                                    ForEach(materialDataManager.materialList.indices,id:\.self){ index in
                                        NavigationLink{
                                            Material_Detail(material: $materialDataManager.materialList[index])
                                        }label: {
                                            Main_Card_View(materialName:materialDataManager.materialList[index].name ?? "", materialUnit: materialDataManager.materialList[index].unit ?? "", materialStock: materialDataManager.materialList[index].currentStock)
                                            
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        //no material
                        } else {
                            VStack {
                                Text("There is no material yet.")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(hex: 0x8E8E93))
                                
                                HStack {
                                    Text("Please tap")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color(hex: 0x8E8E93))
                                    Image(systemName: "plus")
                                        .font(.system(size: 22))
                                        .foregroundColor(.blue)
                                    Text("to add your material")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color(hex: 0x8E8E93))
                                }
                                
                                Image("material_no_data")
                                    .resizable()
                                    .frame(width: 393, height: 256)
                                
                                Image("material_no_data_wave")
                                    .resizable()
                                    .frame(width: 393, height: 104)
                                    .offset(y: 65)
                            }.padding()
                        }
                    }
                }
            }
            .navigationBarTitle("Material")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button {
                            withAnimation {
                                showingSheet = true
                            }
                        }label: {
                            Image(systemName: "info.circle")
                        }.sheet(isPresented: $showingSheet){
                            Indicator_Modal_View(showSheetView: $showingSheet)
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
}

//struct Material_Previews: PreviewProvider {
//    static var previews: some View {
//        Material()
//    }
//}
