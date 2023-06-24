//
//  Production_Detail.swift
//  Restock
//
//  Created by David Christian on 19/06/23.
//

import SwiftUI

struct Production_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                VStack{
                    Image("bouquet")
                        .resizable()
                        .cornerRadius(16)
                        .frame(width: 150, height: 150)
                        .padding(.top)
                    Text("Bouquet Rose")
                        .font(.largeTitle)
                    VStack{
                        List {
                            Section {
                                HStack {
                                    Text("Produce Amount")
                                    Spacer()
                                    Text("4 pcs")
                                }
                                HStack {
                                    Text("Produce Date")
                                    Spacer()
                                    Text("Jun 14, 2023")
                                }
                                HStack {
                                    Text("Produce Label")
                                    Spacer()
                                    Text("Stok Toko")
                                }
                                HStack {
                                    Text("Notes")
                                    Spacer()
                                    Text("-")
                                }
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                    Spacer()
                }
                
            }
            .navigationBarTitle("Production Detail", displayMode: .inline)
            .navigationBarItems(leading: backButton)
        }
        .navigationBarBackButtonHidden(true)
    }
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back") // 2
            }
        })
    }
}

struct Production_Detail_Previews: PreviewProvider {
    static var previews: some View {
        Production_Detail()
    }
}
