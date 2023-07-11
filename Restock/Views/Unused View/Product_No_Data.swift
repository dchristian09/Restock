//
//  Product_No_Data.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 25/06/23.
//

import SwiftUI

struct Product_No_Data: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView{
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
                }.frame(height: 600)
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

struct Product_No_Data_Previews: PreviewProvider {
    static var previews: some View {
        Product_No_Data()
    }
}
