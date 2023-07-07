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
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0xf2f4ff))
                    .ignoresSafeArea()
                ScrollView {
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
                            Section{
                                HStack{
                                    Text("June")
                                    Spacer()
                                }
                                Divider()
                                LazyVGrid(columns: columns){
                                    Text("1")
                                        .font(.title)
                                    NavigationLink{
                                        Production_Detail()
                                    } label:{
                                        Production_Card_View()
                                    }.highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                                        .onEnded { value in
                                            if abs(value.translation.height) < abs(value.translation.width) {
                                                if abs(value.translation.width) > 50.0 {
                                                    if value.translation.width < 0 {
                                                        print("Kiri ke Kanan")
                                                    }else{
                                                        print("Kanan ke kiri")
                                                    }
                                                }
                                            }
                                        }
                                    )
                                }
                            }
                            Section{
                                HStack{
                                    Text("July")
                                    Spacer()
                                }
                                Divider()
                                LazyVGrid(columns: columns){
                                    Text("10")
                                        .font(.title)
                                    NavigationLink{
                                        Production_Detail()
                                    } label:{
                                        Production_Card_View()
                                    }
                                    
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText)
        }
    }
}

//struct History_Previews: PreviewProvider {
//    static var previews: some View {
//        History()
//    }
//}
