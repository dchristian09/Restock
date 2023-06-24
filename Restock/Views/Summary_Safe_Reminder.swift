//
//  Summary_Safe_Reminder.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 24/06/23.
//

import SwiftUI

struct Summary_Safe_Reminder: View {
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                        .fill(.white)
                        .frame(maxHeight: .infinity)
                    
                    VStack {
                        Text("All of your material & product")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: 0x8E8E93))
                        
                        Text("are at a safe level.")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: 0x8E8E93))
                        
                        Image("summary_safe_reminder")
                            .resizable()
                            .frame(width: 390, height: 349)
                        
                        Image("summary_safe_reminder_wave")
                            .resizable()
                            .frame(width: 514, height: 104)
                            .offset(y: 45)
                    }
                }
            }
            .navigationBarTitle("Summary")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Summary_Safe_Reminder_Previews: PreviewProvider {
    static var previews: some View {
        Summary_Safe_Reminder()
    }
}
