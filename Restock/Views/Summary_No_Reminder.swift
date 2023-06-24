//
//  Summary_No_Reminder.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 24/06/23.
//

import SwiftUI

struct Summary_No_Reminder: View {
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
                            Text("There is no summary yet.")
                                .font(.system(size: 22))
                                .foregroundColor(Color(hex: 0x8E8E93))
                            
                            HStack {
                                Text("Please jump to the")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(hex: 0x8E8E93))
                                Image(systemName: "shippingbox")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(hex: 0x8E8E93))
                                Text("material tab")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(hex: 0x8E8E93))
                            }
                            
                                Image("summary_no_reminder")
                                    .resizable()
                                    .frame(width: 389, height: 327)
                                
                                Image("summary_no_reminder_wave")
                                    .resizable()
                                    .frame(width: 416, height: 104)
                                    .offset(y: 55)
                        }
                    }
                }
            .navigationBarTitle("Summary")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Summary_No_Reminder_Previews: PreviewProvider {
    static var previews: some View {
        Summary_No_Reminder()
    }
}
