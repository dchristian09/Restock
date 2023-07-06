//
//  Product.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Product: View {
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var showingAlert: Bool = false
    @State var isNoMaterialAlert = false
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
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
                        if(productDataManager.productList.count > 0){
                            VStack{
                                LazyVGrid(columns: columns){
                                    ForEach(productDataManager.productList.indices,id:\.self){ index in
                                        NavigationLink{
                                            Product_Detail(product: $productDataManager.productList[index])
                                        }label: {
                                            Main_Card_View(materialName: productDataManager.productList[index].name ?? "",  materialUnit: productDataManager.productList[index].unit ?? "", materialStock: productDataManager.productList[index].currentStock)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        else{
                            ZStack{
                                Rectangle()
                                    .fill(Color(hex: 0xf2f4ff))
                                    .ignoresSafeArea()
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                                        .fill(.white)
                                        .frame(maxHeight: .infinity)
                                    
                                    VStack {
                                        Text("There is no product yet.")
                                            .font(.system(size: 22))
                                            .foregroundColor(Color(hex: 0x8E8E93)).padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                                        
                                        HStack {
                                            Text("Please tap")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                            Image(systemName: "plus")
                                                .font(.system(size: 22))
                                                .foregroundColor(.blue)
                                            Text("to add your product")
                                                .font(.system(size: 22))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                        }
                                        
                                        Image("product_no_data")
                                            .resizable()
                                            .frame(width: 393, height: 255)
                                        
                                        Spacer()
                                        Image("product_no_data_wave")
                                            .resizable()
                                            .frame(width: 416, height: 104)
                                            .offset(y: 65)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Product")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    if materialDataManager.materialList.count > 0 {
                                NavigationLink(destination: Product_Add()) {
                                    Image(systemName: "plus")
                                }
                            } else {
                                Button(action: {
                                    // Handle the case where materials list is empty
                                    isNoMaterialAlert = true
                                }) {
                                    Image(systemName: "plus")
                                }
                                .alert(isPresented: $isNoMaterialAlert) {
                                    Alert(title: Text("No Material"), message: Text("Please add material first."), dismissButton: .default(Text("OK")))
                                }
                            }
                }
            }
        }
    }
}


struct Product_Previews: PreviewProvider {
    static var previews: some View {
        Product()
    }
}
