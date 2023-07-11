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
    @State var showingSheet: Bool = false
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack{
                        RoundedRectangle(cornerRadius: 50, style:.continuous)
                            .fill(.white)
                            .frame(maxHeight: .infinity)
                        
                        //there is product
                        if(productDataManager.productList.count > 0){
                            VStack{
                                //low stock product
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Low Stock Product")
                                        .font(.title2.bold())
                                    Spacer()
                                    NavigationLink {
                                        Product_Reminder()
                                    } label: {
                                        Text("View Another")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                    }
                                }.padding()
                                
                                // Product Card
                                LazyVGrid(columns: columns){
                                    ForEach(productDataManager.productList.indices,id:\.self){ index in
                                        NavigationLink{
                                            Product_Detail(product: $productDataManager.productList[index])
                                        }label: {
                                            Main_Card_View(materialName: productDataManager.productList[index].name ?? "",  materialUnit: productDataManager.productList[index].unit ?? "", materialStock: productDataManager.productList[index].currentStock)
                                        }
                                    }
                                }
                                
                                //safe product
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Safe Product")
                                        .font(.title2.bold())
                                    Spacer()
                                }.padding()
                                
                                // Product Card
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
                        //no product
                        else{
                            ZStack{
                                Rectangle()
                                    .fill(Color(hex: 0xF4F4FD))
                                    .ignoresSafeArea()
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                                        .fill(.white)
                                        .frame(maxHeight: .infinity)
                                        .padding(.top, 5)
                                    
                                    VStack {
                                        VStack {
                                            Text("There is no product yet.")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                            
                                            HStack {
                                                Text("Please tap")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color(hex: 0x8E8E93))
                                                Image(systemName: "plus")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.blue)
                                                Text("to add your product")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color(hex: 0x8E8E93))
                                            }
                                        }.padding(.top, 50)
                                        
                                        
                                        Image("product_no_data")
                                            .resizable()
                                            .frame(width: 300, height: 300)
                                        Spacer()
                                    }
                                }.frame(height: 700)
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
                            Product_Add()
                        }label: {
                            Image(systemName: "plus")
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
