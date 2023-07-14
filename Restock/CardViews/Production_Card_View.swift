//
//  Production_Card_View.swift
//  Restock
//
//  Created by David Christian on 15/06/23.
//

import SwiftUI

struct Production_Card_View: View {
    var dataProduction:DataProduction? 
    
    
    
//    var material: DataMaterial {
//
//    }
    @State var itemName: String = ""
//    var item
    @StateObject var productDataManager: ProductDataManager = ProductDataManager.shared
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 16, style:.continuous)
                .fill(Color(hex: 0xF4F4FD))
            ZStack{
                HStack(alignment: .top){
                    VStack{
                        Circle()
                            .fill(dataProduction?.isProduce ?? true ? .green : .red)
                            .frame(width: 8, height: 8, alignment: .leading)
                            .padding([.top, .leading])
                        Spacer()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            // keterangan stock
                            Text("\(dataProduction?.isProduce ?? true ? "Produce" : "Reduce") Stock")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Text("-")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            // keterangan stock
                            Text(dataProduction?.label ?? "Event Graduation")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }.padding(.top, 10)
                        
                        // nama barang
                        Text(itemName)
                            .font(.title)
                            .bold()
                            .padding([.bottom], 0.1)
                            .foregroundColor(.black)
                        //tanggal barang
                        //Text("14/07/2023")
                        Text(dateToString(tanggal:dataProduction?.date))
                            .font(.caption2)
                            .foregroundColor(.black)
            
                    }
                    
                    Spacer()
                    
                    
                    //plus minus stock
                    VStack{
                        Spacer()
                        Text("\(dataProduction?.isProduce ?? true ? "+" : "-")\(dataProduction?.qty ?? 7)")
                            .font(.title)
                            .bold()
                            .foregroundColor(dataProduction?.isProduce ?? true ? .green : .red).padding(10)
                        Spacer()
                    }
                    
                    
                    
                    
                       
                }
               
            }
            
        }.onAppear{
            getName()
        }
        .frame(width:312, height: 72)
    }

    func getName(){
        if dataProduction?.itemType?.lowercased() == "product"{
            let product = productDataManager.productList.filter{
                $0.id == dataProduction?.idProduct
            }
            itemName = product.first!.name!
            
        }else{
            let material = materialDataManager.materialList.filter{
                $0.id == dataProduction?.idProduct
            }
            itemName = material.first!.name!
        }
    }
    
    func dateToString(tanggal:Date?) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        guard let currentDate = tanggal else {
            return " - "
        }
        
        return formatter.string(from: tanggal!)
        
    }
}

//struct Production_Card_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Production_Card_View(, product: .init())
//    }
//}
