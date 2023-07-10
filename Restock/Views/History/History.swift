//
//  History.swift
//  Restock
//
//  Created by David Christian on 06/07/23.
//

import SwiftUI

struct History: View {
    @State var selectedTheme:String = "Product"
    @State var showingSheet: Bool = false
    @State private var searchText = ""
    let themes = ["Product", "Material"]
    let columns = [GridItem(.fixed(35)), GridItem(.flexible())]
    let historyDatas:[HistoryData] = [
        HistoryData(historyMonth: "June", historyDetails: [
            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremony", quantity: 5, isProduce: false),
            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremony", quantity: 5, isProduce: true)
        ]),
        HistoryData(historyMonth: "July", historyDetails: [
            HistoryDetail(historyDate: Date(), itemName: "Rose bouquet", productionLabel: "Graduation Ceremonyx", quantity: 13, isProduce: true)
        ])
    ]
    //    let tgls:[Date] = [
    //        Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
    //        Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
    //        Date()
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
                    
                    VStack{
                        
                        HStack{
                            Spacer()
                            Picker("Appearance", selection: $selectedTheme) {
                                ForEach(themes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                        }
                        HStack{
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
                            Button("Edit"){
                                
                            }.foregroundColor(.blue)
                                .padding(.trailing)
                        }.padding(.bottom)
                        
                        List {
                            ForEach(historyDatas, id: \.historyMonth){ historyData in
                                Section {
                                    HStack{
                                        Text(historyData.historyMonth)
                                        Spacer()
                                    }
                                    //Divider()
                                    ForEach(historyData.historyDetails, id:\.self){ historyDetail in
                                        History_card_view(historyDetail: historyDetail)
                                        
                                    }
                                    
                                    
                                    
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
            .searchable(text: $searchText)
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
