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
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
 
                //   ScrollView {
                ZStack{
                    RoundedRectangle(cornerRadius: 50, style:.continuous)
                        .fill(.white)
                        .frame(maxHeight: .greatestFiniteMagnitude)
                    
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
                        }
                        HStack(alignment: .center){
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
                            Spacer()
//                            Button("Edit"){
//
//                            }.foregroundColor(.blue)
//                                .padding(.trailing)
                        }.padding(.top)
                        
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
                        
                        Spacer()
                    }
                   // .padding()
                }
                //}
 
            }
            .navigationBarTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $productionDataManager.searchText)
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
 
