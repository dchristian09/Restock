//
//  Material_Reminder.swift
//  Restock
//
//  Created by David Christian on 14/06/23.
//

import SwiftUI

struct Material_Reminder: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                ZStack{
                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                        .fill(.white)
                        .frame(height: 700)
                        .offset(y: 65)
                    VStack{
                        LazyVGrid (columns: columns){
                            Main_Card_View()
                            Main_Card_View()
                            Main_Card_View()
                            Main_Card_View()
                        }
                        .offset(y: 70)
                        .padding(.all)
                        Spacer()
                    }
                    
                }
            }
            .navigationBarTitle(Text("Material Reminder"))
            .searchable(text: $searchText)
            .navigationBarItems(leading: backButton)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Summary") // 2
            }
        })
    }
}

struct Material_Reminder_Previews: PreviewProvider {
    static var previews: some View {
        Material_Reminder()
    }
}
