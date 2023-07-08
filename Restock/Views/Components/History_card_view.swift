//
//  History_card_view.swift
//  Restock
//
//  Created by Farid Azhari on 08/07/23.
//

import SwiftUI

struct History_card_view: View {
    var tanggal:String = "1"
    var body: some View {
        
            HStack{
            Text(tanggal)
                .font(.title)
            
            NavigationLink{
                Production_Detail()
            } label:{
                Production_Card_View()
            }
        }
        
    }
}

struct History_card_view_Previews: PreviewProvider {
    static var previews: some View {
        History_card_view()
    }
}
