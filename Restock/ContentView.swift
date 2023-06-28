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
            Summary_No_Reminder()
                .preferredColorScheme(.light)
                .tabItem(){
                    if selection == 0{
                        Image(systemName: "doc.text")
                    }else{
                        Image(systemName: "doc.text").environment(\.symbolVariants, .none)
                    }
                    Text("Summary")
                    
                }
                .tag(0)
            Production_No_Data()
                .preferredColorScheme(.light)
                .tabItem(){
                    if selection == 1{
                        Image(systemName: "wrench.and.screwdriver.fill")
                    }else{
                        Image(systemName: "wrench.and.screwdriver").environment(\.symbolVariants, .none)
                    }
                    Text("Production")
                    
                }
                .tag(1)
            Product()
                .preferredColorScheme(.light)
                .tabItem(){
                    if selection == 2{
                        Image(systemName: "tray")
                    }else{
                        Image(systemName: "tray").environment(\.symbolVariants, .none)
                    }
                    Text("Product")
                }
                .tag(2)
            Material_No_Data()
                .preferredColorScheme(.light)
                .tabItem {
                    if selection == 3{
                        Image(systemName: "shippingbox")
                    }else{
                        Image(systemName: "shippingbox").environment(\.symbolVariants, .none)
                    }
                    Text("Material")
                }
                .tag(3)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            isUser = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
