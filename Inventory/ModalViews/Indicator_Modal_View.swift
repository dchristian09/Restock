//
//  Indicator_Modal_View.swift
//  Inventory
//
//  Created by David Christian on 14/06/23.
//

import SwiftUI


struct Indicator_Modal_View: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top){
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style:.continuous)
                        .fill(.white)
                    VStack{
                        VStack{
                            HStack{
                                Circle()
                                    .fill(.red)
                                    .frame(width: 28, height: 28)
                                Text("Danger")
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            HStack{
                                Text("Red means the inventory is critically low, at or below 50% of the minimum stock required. It indicates an urgent need for replenishment or restocking.")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                            }
                            HStack{
                                Circle()
                                    .fill(.orange)
                                    .frame(width: 28, height: 28)
                                Text("Warning")
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            HStack{
                                Text("Orange signifies that the inventory is below the minimum stock requirement but above 50%. It suggests that the stock is running low and action should be taken soon to avoid potential stockouts.")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                            }
                            HStack{
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 28, height: 28)
                                Text("Caution")
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            HStack{
                                Text("Yellow represents inventory levels that exceed 50% of the minimum stock required. It indicates a healthy amount of stock but serves as a reminder to monitor inventory closely to prevent it from falling below the minimum threshold.")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                            }
                        }
                        
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    
                }
                .frame(width:331, height: 430)
                .padding(.top)
                .presentationDetents([.large])
                
            }
            .navigationBarTitle(Text("Summary Indicator"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
            Button{
                self.showSheetView = false
            }label: {
                Text("Done")
                    .font(.body)
                    .foregroundColor(.blue)
                    .padding()
            }
            )
        }
    }
}

struct Indicator_Modal_View_Previews: PreviewProvider {
    static var previews: some View {
        Indicator_Modal_View(showSheetView: .constant(false))
    }
}
