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
                    VStack(alignment:.center){
                        Spacer()
                        //image barang
                        Image("bouquet")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .padding(.leading, 10.0)
                        Spacer()
                    }
                        
                    VStack(alignment: .leading){
                        Spacer()
                        // nama barang
                        Text("Bouquet Rose")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.bottom, 0.5)
                            .foregroundColor(.black)
                        // keterangan barang
                        Text("Event Graduation")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: 0x8E8E93))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    
                    VStack(alignment: .trailing){
                        Spacer()
                        //jumlah plus minus stock
                        Text("+1")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color(hex: 0x00CA4E))
                        //produce/reduce stock
                        Text("Produce")
                            .font(.system(size: 11))
                            .fontWeight(.regular)
                            .foregroundColor(Color(hex: 0x00CA4E))
                        Spacer()
                    }.padding(.trailing)
                }
            }
        }
        .frame(width:312, height: 72)
    }
}

struct Production_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Production_Card_View()
    }
}
