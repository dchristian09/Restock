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
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 60, style:.continuous)
                            .fill(.white)
                            .frame(maxHeight: .infinity)
                        
                        VStack{
                            LazyVGrid(columns: columns){
                                NavigationLink{
                                    Product_Detail()
                                }label: {
                                    Main_Card_View()
                                }
                            }
                            Spacer()
                        }
                        .padding()
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
                        Production_Stock()
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
