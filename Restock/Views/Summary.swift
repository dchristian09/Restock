//
//  Summary.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct Summary: View {
    @State private var showingSheet = false
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 60, style:.continuous)
                        .fill(.white)
                        .offset(y:90)
                    VStack {
                        HStack {
                            Text("Summary")
                                .font(.largeTitle.bold())
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showingSheet = true
                                }
                            } label: {
                                Image(systemName: "info.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding()
                            }.sheet(isPresented: $showingSheet){
                                Indicator_Modal_View(showSheetView: $showingSheet)
                            }
                        }
                        HStack{
                            Image(systemName: "shippingbox")
                            Text("Material Summary")
                                .font(.title2.bold())
                            Spacer()
                            NavigationLink {
                                Summary_Material()
                            } label: {
                                Text("View Another")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }.padding()
                        
                        LazyVGrid (columns: columns){
                            Main_Card_View()
                                .onLongPressGesture(minimumDuration: 1) {
                                    showingAlert = true
                                }.alert(isPresented: $showingAlert) { () -> Alert in
                                    Alert(title: Text("Reminder - Rose Flower"), message: Text("Choose your next step for this reminder"))
                   
                    }
                            Main_Card_View()
                            Main_Card_View()
                            Main_Card_View()
                        }
                        
                        HStack{
                            Image(systemName: "tray")
                            Text("Product Summary")
                                .font(.title2.bold())
                            Spacer()
                            NavigationLink {
                                Summary_Product()
                            } label: {
                                Text("View Another")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }.padding()
                        
                        LazyVGrid (columns: columns){
                            Main_Card_View()
                            Main_Card_View()
                            Main_Card_View()
                            Main_Card_View()
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
