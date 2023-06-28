//
//  Main_Card_View.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Main_Card_View: View {
    var materialName:String = "Ros"
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16, style:.continuous)
                .fill(Color(hex: 0x3C6EE1))
            ZStack {
                HStack(alignment: .top){
                    VStack {
                        Image("bouquet")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                        Text("Min. Stock: 3 pcs")
                            .font(.system(size: 7))
                            .foregroundColor(.white)
                            .bold()
                    }
                    Text(materialName)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.trailing)
                    
                }.padding(.leading)
                    .frame(maxWidth:.infinity, alignment: .leading)
                Circle()
                    .fill(.white)
                    .offset(x: 67, y: 25)
                    .frame(width: 56, height: 56)
                Text("100")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: 0x3C6EE1))
                    .offset(x: 67, y: 20)
                Text("pcs")
                    .font(.caption2)
                    .foregroundColor(Color(hex: 0x3C6EE1))
                    .offset(x: 67, y: 35)
            }

        }
        .frame(width:177, height: 98)
        
    }
}

struct Main_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Main_Card_View()
    }
}
