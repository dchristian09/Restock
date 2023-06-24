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
                .fill(Color(hex: 0x3C6EE1))
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
                        Text("Produce Stock")
                            .font(.subheadline)
                            .padding(.top, 10)
                            .foregroundColor(.white)
                        Text("Bouquet Rose")
                            .font(.title)
                            .bold()
                            .padding([.bottom], 0.1)
                            .foregroundColor(.white)
                        Text("14/07/2023")
                            .font(.caption2)
                            .foregroundColor(.white)
                        
                    }
                    VStack{
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 41, height: 41)
                                .offset(x: 65, y: 25)
                            Text("+1")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.green)
                                .offset(x: 65, y: 25)
                        }
                        
                    }
                    Spacer()
                    
                }
            }
        }
        .frame(width:348, height: 94)
    }
}

struct Production_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Production_Card_View()
    }
}
