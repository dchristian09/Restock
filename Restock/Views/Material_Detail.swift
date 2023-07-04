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
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
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
                    VStack{
                        List {
                            Section{
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
