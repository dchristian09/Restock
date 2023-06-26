//
//  Splash_Screen.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 26/06/23.
//

import SwiftUI

struct Splash_Screen: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: 0xf2f4ff))
                .ignoresSafeArea()
            if self.isActive {
                On_Boarding_Screen()
            } else {
                Image("splash_screen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
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

struct Splash_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Splash_Screen()
    }
}
