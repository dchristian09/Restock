//
//  Product_Stock.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

import SwiftUI

struct Product_Stock: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var itemAmount: String = ""
    @State private var itemNote: String = ""
    @State private var itemLabel: String = ""
    @State private var itemDate = Date.now
    var stockOption:String = ""
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack {
                        //image
                        Image("bouquet")
                            .resizable()
                            .cornerRadius(16)
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                            .padding(.top)
                        //text
                        Text("Flower Bouquet")
                            .font(.largeTitle)
                    }
                    Form {
                        HStack{
                            Text((stockOption)+" Amount")
                            TextField("Amount", text: $itemAmount)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text((stockOption)+" Date")
                            DatePicker(selection: $itemDate, in: ...Date.now, displayedComponents: .date) {
                                
                            }
                        }
                        HStack{
                            Text((stockOption)+" Label")
                            TextField("Amount", text: $itemLabel)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                        }
                        TextField((stockOption)+" Notes", text: $itemNote)
                            .keyboardType(.default)
                    }
                }
            }
            .navigationBarTitle((stockOption), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    //                    if selectedTheme == "Produce Stock"{
                    //                        Button("Restock") {
                    //                            //function
                    //                        }
                    //                    }else{
                    //                        Button("Reduce") {
                    //                            //function
                    //                        }
                    //                    }
                    Button(stockOption) {
                        //function
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct Product_Stock_Previews: PreviewProvider {
//    static var previews: some View {
//        Product_Stock()
//    }
//}
