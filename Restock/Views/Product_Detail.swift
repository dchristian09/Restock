//
//  Product_Detail.swift
//  Restock
//
//  Created by David Christian on 22/06/23.
//

import SwiftUI

struct Product_Detail: View {
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
                        .cornerRadius(16)
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                        .padding(.top)
                    Text("Bouquet Rose")
                        .font(.largeTitle)
                    VStack{
                        List {
                            Section{
                                HStack {
                                    Text("Current Stock")
                                    Spacer()
                                    Text("1 pcs")
                                }
                                HStack {
                                    Text("Minimal Stock")
                                    Spacer()
                                    Text("3 pcs")
                                }
                                HStack {
                                    Text("Tissue Paper")
                                    Spacer()
                                    Text("5 pcs")
                                }
                                HStack {
                                    Text("Rose Flower")
                                    Spacer()
                                    Text("5 pcs")
                                }
                                HStack {
                                    Text("Lem Fox")
                                    Spacer()
                                    Text("20 gram")
                                }
                                HStack {
                                    Text("Red Ribbon")
                                    Spacer()
                                    Text("1 pcs")
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                    Spacer()
                }
                
            }
            .navigationBarTitle("Product Detail", displayMode: .inline)
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
                        Product_Edit()
                    }label: {
                        Text("Edit")
                    }
                    
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
}


struct Product_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Product_Detail()
    }
}
