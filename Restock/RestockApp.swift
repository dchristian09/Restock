//
//  RestockApp.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

@main
struct RestockApp: App {
    @AppStorage("isUser") var isUser: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if(!isUser){
                NavigationStack{
                    Splash_Screen()
                }
            }else{
                ContentView()
            }
            
            
        }
    }
}
