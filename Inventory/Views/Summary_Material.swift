//
//  Summary_Inventory.swift
//  Inventory
//
//  Created by David Christian on 14/06/23.
//

import SwiftUI

struct Summary_Material: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                ZStack{
                    RoundedRectangle(cornerRadius: 60, style:.continuous)
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

struct Summary_Material_Previews: PreviewProvider {
    static var previews: some View {
        Summary_Material()
    }
}
