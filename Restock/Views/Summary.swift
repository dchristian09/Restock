//
//  Summary.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct Summary: View {
    init() {
        getUrgentStock()
    }
    @State var urgentMaterial: [DataMaterial] = []
    @State var urgentProduct: [DataProduct] = []
    
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    
    @State private var showingSheet = false
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    @State var cekekek: Bool = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                        .fill(.white)
                        .offset(y:90)
                    VStack {
                        HStack {
                            Text("Summary")
                                .font(.largeTitle.bold())
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showingSheet = true
                                }
                            } label: {
                                Image(systemName: "info.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding()
                            }.sheet(isPresented: $showingSheet){
                                Indicator_Modal_View(showSheetView: $showingSheet)
                            }
                        }
                        
                        //if still no material. Summary_no_reminder
                        if(productDataManager.productList.count == 0 && materialDataManager.materialList.count == 0){
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
                            }.padding(35)
                        }else{
//                            if there is urgent material
                            if (urgentMaterial.count > 0 ){
        //                        Material Reminder
                                HStack{
                                    Image(systemName: "shippingbox")
                                    Text("Material Reminder")
                                        .font(.title2.bold())
                                    Spacer()
                                    NavigationLink {
                                        Material_Reminder()
                                    } label: {
                                        Text("View Another")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                    }
                                }.padding()
                                
        //                        Material Card
                                LazyVGrid (columns: columns){
                                    Main_Card_View()
                                        .onLongPressGesture(minimumDuration: 1) {
                                            showingAlert = true
                                        }.alert("Reminder - Red Ribbon", isPresented: $showingAlert, actions: {
                                            Button("Produce Material", action: {})
                                            Button("Deactivate Material", role: .destructive, action: {})
                                        }, message: {
                                            Text("Choose your next step for this reminder")
                                        })
                                    Main_Card_View()
                                        .onLongPressGesture(minimumDuration: 1) {
                                            showingAlert = true
                                        }.alert("Reminder - Red Ribbon", isPresented: $showingAlert, actions: {
                                            Button("Produce Material", action: {})
                                            Button("Deactivate Material", role: .destructive, action: {})
                                        }, message: {
                                            Text("Choose your next step for this reminder")
                                        })
                                }
                            }
                            
//                            if there is urgent product
                            if (urgentProduct.count > 0 ){
        //                        Product Reminder
                                HStack{
                                    Image(systemName: "tray")
                                    Text("Product Reminder")
                                        .font(.title2.bold())
                                    Spacer()
                                    NavigationLink {
                                        Product_Reminder()
                                    } label: {
                                        Text("View Another")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                    }
                                }.padding()
                                
        //                        Product Card
                                LazyVGrid (columns: columns){
                                    Main_Card_View()
                                        .onLongPressGesture(minimumDuration: 1) {
                                            cekekek = true
                                        }.alert("Reminder - Red Ribbon", isPresented: $cekekek, actions: {
                                            Button("Produce Product", action: {})
                                            Button("Deactivate Product", role: .destructive, action: {})
                                        }, message: {
                                            Text("Choose your next step for this reminder")
                                        })
                                    Main_Card_View()
                                        .onLongPressGesture(minimumDuration: 1) {
                                            cekekek = true
                                        }.alert("Reminder - Red Ribbon", isPresented: $cekekek, actions: {
                                            Button("Produce Product", action: {})
                                            Button("Deactivate Product", role: .destructive, action: {})
                                        }, message: {
                                            Text("Choose your next step for this reminder")
                                        })
                                    
                                }
                            }
                            
                        }
                        
//

                

                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        
        
    }
    func getUrgentStock(){
        urgentMaterial = materialDataManager.materialList.filter { material in
                return material.minimalStock > material.currentStock
            }
        
        urgentProduct = productDataManager.productList.filter { product in
                return product.minimalStock > product.currentStock
            }
    }
}



struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
