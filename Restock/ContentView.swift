//
//  ContentView.swift
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

struct ContentView: View {
    @State private var selection = 0
    @AppStorage("isUser") var isUser: Bool = false
    var body: some View {
        TabView(selection: $selection){
            Product()
                .preferredColorScheme(.light)
                .tabItem(){
//                    if selection == 0{
//                        Image(systemName: "tray")
//                    }else{
//                        Image(systemName: "tray").environment(\.symbolVariants, .none)
//                    }
//                    Text("Product")
                    Image(systemName: "tray").environment(\.symbolVariants, .none)
                    Text("Product")
                }.tag(0)
            Material()
                .preferredColorScheme(.light)
                .tabItem {
                    Image(systemName: "shippingbox").environment(\.symbolVariants, .none)
                    Text("Material")
                }.tag(1)
            History()
                .preferredColorScheme(.light)
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }.tag(2)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            isUser = true
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
