//
//  Material_Detail.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI

struct Material_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var material: DataMaterial
    //    var stockOption:String = ""
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    Image("bouquet")
                        .resizable()
                        .cornerRadius(16)
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                        .padding(.top)
                    Text($material.wrappedValue.name ?? "")
                        .font(.largeTitle)
                    HStack{
                        
                        NavigationLink{
                            Material_Stock(stockOption: "Restock")
                        }label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Restock") // 2
                            }.padding(15)
                                .foregroundColor(.white)
                                .background(.green)
                                .cornerRadius(8)
                            
                        }
                        NavigationLink{
                            Material_Stock(stockOption: "Reduce")
                        }label: {
                            HStack {
                                Image(systemName: "minus.circle")
                                Text("Reduce") // 2
                            }.padding(15)
                                .foregroundColor(Color(hex: 0xff605c))
                                .background(.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: 0xff605c))
                                )
                        }
                        
                    }
                    VStack{
                        List {
                            Section(header: Text("Stock")){
                                HStack {
                                    Text("Current Stock")
                                    Spacer()
                                    Text(String($material.wrappedValue.currentStock) + " " + ($material.wrappedValue.unit ?? ""))
                                }
                                HStack {
                                    Text("Minimal Stock")
                                    Spacer()
                                    Text(String($material.wrappedValue.minimalStock) + " " + ($material.wrappedValue.unit ?? ""))
                                }
                            }
                            Section(header: Text("Notes")){
                                HStack {
                                    Text("Notes")
                                    Spacer()
                                    Text($material.wrappedValue.note ?? "-")
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                    Spacer()
                }
                
            }
            .navigationBarTitle("Material Detail", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back") // 2
                        }
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        Material_Edit()
                    }label: {
                        Text("Edit")
                    }
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

//struct Material_Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Material_Detail()
//    }
//}
