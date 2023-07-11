//
//  Product_Detail.swift
//  Restock
//
//  Created by David Christian on 22/06/23.
//

import SwiftUI

struct Product_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var product: DataProduct
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    //image
                    Image("bouquet")
                        .resizable()
                        .cornerRadius(16)
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                        .padding(.top)
                    //text
                    Text($product.wrappedValue.name ?? "")
                        .font(.largeTitle)
                    //button
                    HStack{
                        NavigationLink{
                            Product_Stock(stockOption: "Produce")
                        }label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Produce") // 2
                            }.padding(15)
                                .foregroundColor(.white)
                                .background(.green)
                                .cornerRadius(8)
                            
                        }
                        NavigationLink{
                            Product_Stock(stockOption: "Reduce")
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
                            //stock section
                            Section(header: Text("Stock")){
                                HStack {
                                    Text("Current Stock")
                                    Spacer()
                                    Text(String($product.wrappedValue.currentStock) + " " + ($product.wrappedValue.unit ?? ""))
                                }
                                HStack {
                                    Text("Minimal Stock")
                                    Spacer()
                                    Text(String($product.wrappedValue.minimalStock) + " " + ($product.wrappedValue.unit ?? ""))
                                }
                            }
                            //materials section
                            Section(header: Text("Materials")){
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


//struct Product_Detail_Previews: PreviewProvider {
//    @State static var teamp:DataProduct  = DataProduct()
//    static var previews: some View {
//        Product_Detail(product: $teamp)
//    }
//}
