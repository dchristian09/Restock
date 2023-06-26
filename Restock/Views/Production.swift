//
//  Production.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Production: View {
    @State private var searchText = ""
    let columns = [GridItem(.flexible())]
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
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                NavigationLink{
                                    Production_Detail()
                                } label:{
                                    Production_Card_View()
                                }
                                
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Production")
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

struct Production_Previews: PreviewProvider {
    static var previews: some View {
        Production()
    }
}
