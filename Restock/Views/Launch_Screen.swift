//
//  Launch_Screen.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 26/06/23.
//

import SwiftUI

struct Launch_Screen: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: 0xF4F4FD))
                .ignoresSafeArea()
            if self.isActive {
                Product()
            } else {
//                Image("launch_screen")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
            }
        }
        .preferredColorScheme(.light)
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct Launch_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Launch_Screen()
    }
}
