//
//  Material_Detail.swift
//  Restock
//
//  Created by David Christian on 23/06/23.
//

import SwiftUI

struct Material_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    Image("bouquet")
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 150, height: 150)
                        .padding(.top)
                    Text("Bouquet Rose")
                        .font(.largeTitle)
                    VStack{
                        List {
                            Section{
                                HStack {
                                    Text("Minimal Stock")
                                    Spacer()
                                    Text("3 pcs")
                                }
                            }
                            Section{
                                HStack {
                                    Text("Current Stock")
                                    Spacer()
                                    Text("1 pcs")
                                }
                            }
                            Section{
                                HStack {
                                    Text("Notes")
                                    Spacer()
                                    Text("-")
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

struct Material_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Material_Detail()
    }
}
