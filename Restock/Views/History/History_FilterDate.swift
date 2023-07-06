//
//  History_FilterDate.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

import SwiftUI

struct History_FilterDate: View {
    @Binding var showSheetView: Bool
    @State var startDate = Date.now
    @State var endDate = Date.now
    var body: some View {
        NavigationView {
            ZStack (alignment: .top){
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    List{
                        //current stock
                        HStack{
                            Text("Start Date")
                            DatePicker(selection: $startDate, in: ...Date.now, displayedComponents: .date) {
                                
                            }
                        }
                        
                        //minimal stock
                        HStack{
                            Text("End Date")
                            DatePicker(selection: $endDate, in: ...Date.now, displayedComponents: .date) {
                                
                            }
                        }
                    }
                }
                .presentationDetents([.large])
            }
            .navigationBarTitle(Text("Filter Date"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.showSheetView = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        
                    }label: {
                        Text("Apply")
                    }
                    
                }
            }
        }
        
    }
    
}


struct History_FilterDate_Previews: PreviewProvider {
    static var previews: some View {
        History_FilterDate(showSheetView: .constant(false))
    }
}
