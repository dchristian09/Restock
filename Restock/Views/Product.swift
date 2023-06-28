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
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
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
                                        ForEach(productDataManager.productList,id:\.id){ product in
                                            NavigationLink{
                                                Product_Detail()
                                            }label: {
                                                Main_Card_View(materialName: product.nama ?? "")
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


struct Product_Previews: PreviewProvider {
    static var previews: some View {
        Product()
    }
}
