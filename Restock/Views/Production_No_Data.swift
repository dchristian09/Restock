//
//  Production_No_Data.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 24/06/23.
//

import SwiftUI

struct Production_No_Data: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .fill(.white)
                        .frame(maxHeight: .infinity)
                    
                    VStack {
                        Text("There is no production yet.")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: 0x8E8E93))
                        
                        HStack {
                            Text("Please tap")
                                .font(.system(size: 22))
                                .foregroundColor(Color(hex: 0x8E8E93))
                            Image(systemName: "plus")
                                .font(.system(size: 22))
                                .foregroundColor(.blue)
                            Text("to start your production")
                                .font(.system(size: 22))
                                .foregroundColor(Color(hex: 0x8E8E93))
                        }
                        
                        Image("production_no_data")
                            .resizable()
                            .frame(width: 393, height: 248)
                        
                        Image("production_no_data_wave")
                            .resizable()
                            .frame(width: 395, height: 104)
                            .offset(y: 70)
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

struct Production_No_Data_Previews: PreviewProvider {
    static var previews: some View {
        Production_No_Data()
    }
}
