//
//  Material_Stock.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

import SwiftUI

struct Material_Stock: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var materialDataManager: MaterialDataManager = MaterialDataManager.shared
    @StateObject var productionDataManager: ProductionDataManager = ProductionDataManager.shared
    @StateObject var labelDataManager: LabelDataManager = LabelDataManager.shared
    
//    @Binding var product: DataProduct
    @State var item: DataMaterial 
    @State var itemAmount: String = ""
    @State var itemNote: String = ""
    @State var itemLabel: String = ""
    @State var itemDate = Date.now
    
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
//                        Image("bouquet")
                        Image(uiImage: UIImage(data: item.image!)!)
                            .resizable()
                            .cornerRadius(16)
                            .scaledToFit()
                            .frame(width: 300, height: 250)
                            .padding(.top)
                        //text
                        Text(item.name!)
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
                            TextField("Label", text: $itemLabel)
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
                        Production()
                        
                    }.disabled(itemAmount == "" && itemLabel == "")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func Production(){

//        Kalau restock
        if stockOption == "Restock"{
            
//            material di +
            materialDataManager.restockMaterial(material: item, currentStock: item.currentStock + (Int32(itemAmount)!))
            
//            production nyatet, isProduce = true, item type material
            productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Material")
            
//            Kalau materialnya juga product, product jg d +,
            if item.isProduct{
                let product = ProductDataManager.shared.productList.filter{
                    $0.name == item.name
                }
                
//                product +
                ProductDataManager.shared.produceProduct(product: product[0], currentStock: product[0].currentStock + (Int32(itemAmount)!))
                
//                production nyatet isProduce true, itemType: Product
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: true, productionQty: Int32(itemAmount)!, product_id: product.first!.id!, itemType: "Product")
            }
            self.presentationMode.wrappedValue.dismiss()
        }else{
            
//            Kalau reduce, material -
            materialDataManager.restockMaterial(material: item, currentStock: item.currentStock - (Int32(itemAmount)!))
            
//            production is Prouce = false, itemType = Material
            productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: Int32(itemAmount)!, product_id: item.id!, itemType: "Material")
            
            if item.isProduct{
//                Kalau isProduct, product -
                let product = ProductDataManager.shared.productList.filter{
                    $0.name == item.name
                }
                
                ProductDataManager.shared.produceProduct(product: product[0], currentStock: product[0].currentStock - (Int32(itemAmount)!))
                
//                production jg -
                productionDataManager.addDataToCoreData(productionLabel: itemLabel, productionDate: itemDate, productionNotes: itemNote, isProduce: false, productionQty: Int32(itemAmount)!, product_id: product.first!.id!, itemType: "Product")
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

//struct Material_Stock_Previews: PreviewProvider {
//    static var previews: some View {
//        Material_Stock()
//    }
//}
