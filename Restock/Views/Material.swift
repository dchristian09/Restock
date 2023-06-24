//
//  Material.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI
import PhotosUI

struct Material: View {
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
                        RoundedRectangle(cornerRadius: 50, style:.continuous)
                            .fill(.white)
                            .frame(maxHeight: .infinity)
                        
                        VStack{
                            LazyVGrid(columns: columns){
                                NavigationLink{
                                    Material_Detail()
                                }label: {
                                    Main_Card_View()
                                }
                                NavigationLink{
                                    Material_Detail()
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
            .navigationBarTitle("Material")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        Material_Add()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

struct Material_Previews: PreviewProvider {
    static var previews: some View {
        Material()
    }
}
