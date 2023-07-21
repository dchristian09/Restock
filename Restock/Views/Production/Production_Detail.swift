//
//  Production_Detail.swift
//  Restock
//
//  Created by David Christian on 19/06/23.
//

import SwiftUI

struct Production_Detail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var production: DataProduction
    
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    
    @State var itemName : String = ""
    @State var itemUnit : String = ""
    @State var itemImage : Data = Data()
    
    var body: some View {
        
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                VStack{
//                    Image("bouquet")
                    if(UIImage(data: itemImage) != nil) {
                        let uiimage = UIImage(data: itemImage)
                        Image(uiImage: uiimage!)
                            .resizable()
                            .cornerRadius(16)
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                            .padding(.top)
                    }else{
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 180, height: 180)
                    }
                    Spacer()
                        
                    Text(itemName)
                        .font(.largeTitle)
                    VStack{
                        List {
                            Section {
                                HStack {
                                    Text(production.isProduce ? "Produce " + "Amount" : "Reduce " + "Amount")
                                    Spacer()
                                    Text(String(production.qty) + " " + itemUnit)
                                }
                                HStack {
                                    Text(production.isProduce ? "Produce " + "Date" : "Reduce " + "Date")
                                    Spacer()
                                    Text(dateToString(tanggal:production.date))
                                }
                                HStack {
                                    Text(production.isProduce ? "Produce " + "Label" : "Reduce " + "Label")
                                    Spacer()
                                    Text(production.label!)
                                }
                                HStack {
                                    Text("Notes")
                                    Spacer()
                                    Text(production.notes != "" ? production.notes! : "-")
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
        }.onAppear{
            getData()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func getData(){
        if production.itemType?.lowercased() == "product"{
            let product = productDataManager.productList.filter{
                $0.id == production.idProduct
            }
            itemName = product.first!.name!
            itemUnit = product.first!.unit!
            itemImage = product.first!.image!
            
            
        }else{
            let material = materialDataManager.materialList.filter{
                $0.id == production.idProduct
            }
            itemName = material.first!.name!
            itemUnit = material.first!.unit!
            itemImage = material.first!.image!
        }
    }
    
    func dateToString(tanggal:Date?) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        guard let currentDate = tanggal else {
            return " - "
        }
        
        return formatter.string(from: tanggal!)
        
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

//struct Production_Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Production_Detail()
//    }
//}
