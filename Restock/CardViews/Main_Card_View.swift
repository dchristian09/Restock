//
//  Main_Card_View.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Main_Card_View: View {
    var materialName:String = "Rose Bouquet"
    var materialUnit: String = "pcs"
    var materialStock: Int32 = 0
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16, style:.continuous)
                .fill(Color(hex: 0xF2F4FF))
            ZStack {
                HStack(alignment: .top){
                    
                    //image
                    Image("bouquet")
                        .resizable()
                        .frame(width: 53, height: 54)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.leading, 7.0)
                    
                    VStack(alignment:.leading){
                        
                        //stock name
                        Text(materialName)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .bold()
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                        
                        //current stock
                        Text(String(materialStock)+" "+(materialUnit)+" left")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.trailing)
                        
                        //spacer
                        Text("")
                            .font(.system(size: 11))
                        
                        //min stock
                        Text("Min Stock: "+(String(materialStock))+" "+(materialUnit))
                            .font(.system(size: 10))
                            .fontWeight(.thin)
                            .foregroundColor(.black)
                    }.multilineTextAlignment(.leading)
                    Circle()
                        .fill(.red)
                        .frame(width: 8, height: 8)
                        .padding(.trailing, 4.0)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
            }
        }
        .frame(width:172, height: 68)
    }
}

struct Main_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Main_Card_View()
    }
}
