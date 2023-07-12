//
//  ContentView.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

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
                }
            Material()
                .preferredColorScheme(.light)
                .tabItem {
                    Image(systemName: "shippingbox").environment(\.symbolVariants, .none)
                    Text("Material")
                }
            History()
                .preferredColorScheme(.light)
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
            
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
