//
//  History.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

//import CoreData
import SwiftUI

struct History: View {
    @State var selectedTheme:String = "Product"
    @State var showingSheet: Bool = false
    @State private var searchText = ""
    let themes = ["Product", "Material"]
    let columns = [GridItem(.fixed(35)), GridItem(.flexible())]
    
    @StateObject var productionDataManager = ProductionDataManager.shared
    //@State var historyDatas = ProductionDataManager.shared.historyDatas
    //@State var historyDatas:[HistoryData] = []
    
    //        HistoryData(historyMonth: "June", historyDetails: [
    //            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremony", quantity: 5, isProduce: false),
    //            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremony", quantity: 5, isProduce: true)
    //        ]),
    //        HistoryData(historyMonth: "July", historyDetails: [
    //            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremonyx", quantity: 13, isProduce: true)
    //        ])
    //    ]
    @State var currentMonth:String = "0"
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xF4F4FD))
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 50, style:.continuous)
                    .fill(.white)
                    .frame(maxHeight: .greatestFiniteMagnitude)
                //   ScrollView {
                ZStack{
                    VStack(alignment: .center){
                        HStack{
                            Spacer()
                            Picker("Appearance", selection: $productionDataManager.selectedType) {
                                ForEach(themes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                        }.padding(.all)
                        HStack(alignment: .center){
                            if (productionDataManager.historyDatas.count > 0){
                                Button{
                                    withAnimation{
                                        showingSheet = true
                                    }
                                }label: {
                                    Text("Filter Date")
                                        .foregroundColor(.blue)
                                        .padding(.leading)
                                    Image(systemName: "calendar")
                                        .foregroundColor(.blue)
                                }.sheet(isPresented: $showingSheet){
                                    History_FilterDate(showSheetView: $showingSheet)
                                }
                            }
                            Spacer()
                            //                            Button("Edit"){
                            //
                            //                            }.foregroundColor(.blue)
                            //                                .padding(.trailing)
                        }.padding(.top)
                        if (productionDataManager.historyDatas.count > 0){
                            List {
                                //ForEach(historyDatas, id: \.historyMonth){ historyData in
                                ForEach(productionDataManager.historyDatas, id: \.historyMonth){ historyData in
                                    Section {
                                        //Divider()
                                        ForEach(historyData.historyDetails, id:\.self){ historyDetail in
                                            History_card_view(dataProduction: historyDetail)
                                            
                                        }
                                    } header: {
                                        //                                    HStack{
                                        Text(String(historyData.historyMonth)).padding(5).font(.title2)
                                        //                                        Spacer()
                                        //                                    }
                                    }
                                }
                            }.listStyle(.plain)
                        }else{
                            VStack {
                                VStack {
                                    Text("There is no history available.")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(hex: 0x8E8E93))
                                    Text("It will be generated when you Produce")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(hex: 0x8E8E93))
                                    
                                    HStack {
                                        Text("or Reduce in the")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(hex: 0x8E8E93))
                                        if (productionDataManager.selectedType == "Product"){
                                            Image(systemName: "tray")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                            Text("Product tab")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                        }else{
                                            Image(systemName: "shippingbox")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                            Text("Material tab")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: 0x8E8E93))
                                        }
                                    }
                                }
                                
                                Image("history_no_data")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                Spacer()
                            }
                        }
                    }
                    // .padding()
                }
                //}
                
            }
            .navigationBarTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            //            .searchable(text: $productionDataManager.searchText)
        }
        
        //        .onAppear{
        //            let fetchRequest: NSFetchRequest<DataProduction> = DataProduction.fetchRequest()
        //
        //            do {
        //                var pd:[DataProduction] = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        //                print(pd)
        //                pd[0].productRelation?.name
        //            } catch {
        //                print("gagal")
        //            }
        //        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}

