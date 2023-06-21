//
//  Main_Card_View.swift
//  Inventory
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

struct Main_Card_View: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20, style:.continuous)
                .fill(.blue)
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
                    Text("Rose Flower")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .bold()
                    
                }
                Circle()
                    .fill(.white)
                    .offset(x: 67, y: 25)
                    .frame(width: 56, height: 56)
                Text("100")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.blue)
                    .offset(x: 67, y: 20)
                Text("pcs")
                    .font(.caption2)
                    .foregroundColor(.blue)
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
