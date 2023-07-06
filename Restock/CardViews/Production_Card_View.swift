//
//  Production_Card_View.swift
//  Restock
//
//  Created by David Christian on 15/06/23.
//

import SwiftUI

struct Production_Card_View: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16, style:.continuous)
                .fill(Color(hex: 0xF2F4FF))
            ZStack{
                HStack(alignment: .top){
                    VStack{
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8, alignment: .leading)
                            .padding([.top, .leading])
                        Spacer()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            // keterangan stock
                            Text("Produce Stock")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Text("-")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            // keterangan stock
                            Text("Event Graduation")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }.padding(.top, 10)
                        
                        // nama barang
                        Text("Bouquet Rose")
                            .font(.title)
                            .bold()
                            .padding([.bottom], 0.1)
                            .foregroundColor(.black)
                        //tanggal barang
                        Text("14/07/2023")
                            .font(.caption2)
                            .foregroundColor(.black)
                        
                    }
                    Spacer()
                    
                }
                //plus minus stock
                Text("+1")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .offset(x: 120)
            }
            
        }
        
        .frame(width:312, height: 94)
        
    }
}

struct Production_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Production_Card_View()
    }
}
