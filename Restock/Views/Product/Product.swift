//
//  Product.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Product: View {
//    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var showingAlert: Bool = false

    @State var isNoMaterialAlert = false

    @State var showingSheet: Bool = false

    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    
    
    
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
                        
                        
                        //there is product
                        if(productDataManager.productList.count > 0){
                            VStack{
                                //low stock product
                                HStack{
                                    Image(systemName: "bell")
                                        .font(.system(size: 20))
                                    Text("Low Stock Product")
                                        .font(.title2.bold())
                                    Spacer()
                                    
                                    if productDataManager.urgentProducts.count > 4 {
                                        NavigationLink {
                                            Product_Reminder()
                                        } label: {
                                            Text("View Another " + String(productDataManager.urgentProducts.count))
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }.padding()
                                
                                // Product Card
                                if productDataManager.urgentProducts.count > 0 {
                                    LazyVGrid(columns: columns){
                                        ForEach(productDataManager.urgentProducts.indices,id:\.self){ index in
                                            NavigationLink{
                                                Product_Detail(product: productDataManager.urgentProducts[index])
                                            }label: {
                                                Main_Card_View(materialName: productDataManager.urgentProducts[index].name ?? "",  materialUnit: productDataManager.urgentProducts[index].unit ?? "", materialStock: productDataManager.urgentProducts[index].currentStock, materialMinStock: productDataManager.urgentProducts[index].minimalStock)
                                            }
                                        }
                                    }
                                }else if materialDataManager.urgentMaterial.isEmpty && productDataManager.searchText.isEmpty{
                                    //Low stock empty state
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("Yay!  All your product at a safe level~")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                }else if productDataManager.urgentProducts.isEmpty && !productDataManager.searchText.isEmpty{
                                    //Low Stock empty state on search
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("No Product Match")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
                                }
                                
                                //safe product
                                HStack{
                                    Image(systemName: "tray")
                                        .font(.system(size: 20))
                                    Text("Safe Product")
                                        .font(.title2.bold())
                                    Spacer()
                                }.padding()
                                
                                if !productDataManager.safeProducts.isEmpty{
                                    // Product Card
                                    LazyVGrid(columns: columns){
                                        ForEach(productDataManager.safeProducts.indices,id:\.self){ index in
                                            NavigationLink{
                                                Product_Detail(product: productDataManager.safeProducts[index])
                                            }label: {
                                                Main_Card_View(materialName: productDataManager.safeProducts[index].name ?? "",  materialUnit: productDataManager.safeProducts[index].unit ?? "", materialStock: productDataManager.safeProducts[index].currentStock, materialMinStock: productDataManager.safeProducts[index].minimalStock)
                                            }
                                        }
                                    }
                                }else if productDataManager.safeProducts.isEmpty && !productDataManager.searchText.isEmpty{
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            Spacer()
                                            Text("No Product Match")
                                            Spacer()
                                        }
                                        Spacer()
                                    }.padding(10)
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
            .searchable(text: $productDataManager.searchText)
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
//g tau ini bagian yang mana
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
//        .onAppear{
//            getUrgentStock()
//        }
    }
    
    
    
//    func getUrgentStock(){
//        productDataManager.urgentProducts = productDataManager.productList.filter { product in
//            product.minimalStock > product.currentStock
//        }
//    }
}


//struct Product_Previews: PreviewProvider {
//    static var previews: some View {
//        Product()
//    }
//}
