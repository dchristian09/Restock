//
//  History_card_view.swift
//  Restock
//
//  Created by Farid Azhari on 08/07/23.
//

import SwiftUI

struct History_card_view: View {
    var dataProduction:DataProduction
    var body: some View {
        
            HStack{
                Text("\(Calendar.current.dateComponents([.day], from: dataProduction.date!).day!)")
                .font(.title)
            
            NavigationLink{
                Production_Detail()
            } label:{
                Production_Card_View(dataProduction: dataProduction)
            } .swipeActions() {
                Button("Delete") {
                    
                }.tint(.red) 
            }
        }
        
    }
}

//struct History_card_view_Previews: PreviewProvider {
//    static var previews: some View {
//        History_card_view(historyDetail: HistoryDetail())
//    }
//}
