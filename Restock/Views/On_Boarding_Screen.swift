//
//  On_Boarding_Screen.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 25/06/23.
//

import SwiftUI

struct On_Boarding_Screen: View {
    
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentPage = 0
    var lastPage = data.count - 1
    var firstPage = 0
    var secondPage = 0
    
    @Namespace var namespace
    var body: some View {
        ZStack {
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(data) { item in
                        ItemView(item: item, imageBaseName: item.image,  itemImage: item.image)
                            .frame(width: screenWidth)
                    }
                }
                .offset(x: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            onChanged(value: value)
                        })
                        .onEnded({ value in
                            onEnded(value: value)
                        })
                )
            }
            
            VStack(spacing: 20) {
                Spacer()
                HStack(spacing: 6){
                    ForEach(0..<data.count) { i in
                        if i == currentPage {
                            Circle()
                                .matchedGeometryEffect(id: "page", in: namespace)
                                .frame(width: 10, height: 10)
                                .animation(.default)
                                .foregroundColor(Color(hex: 0x3C6EE1))
                                .offset(y: -50)
                        } else {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color(hex: 0x999999))
                                .offset(y: -50)
                        }
                    }
                }
                
                ZStack {
                    if currentPage != lastPage {
                        HStack {
                            Button(action: {
                                currentPage = lastPage
                                withAnimation{xOffset = -screenWidth * CGFloat(currentPage)}
                            }, label: {
                                Text("Skip")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                            })
                            Spacer()
                            
                            Button(action: {
                                currentPage += 1
                                withAnimation{xOffset = -screenWidth * CGFloat(currentPage)}
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(hex: 0x3C6EE1))
                                        .frame(width: 55, height: 51)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                }
                                .font(.system(size: 17, weight: .bold))
                                .frame(maxWidth: .infinity)
                            })
                        }
                        .frame(height: 60)
                        .foregroundColor(.white)
                    } else {
                        NavigationLink(destination: ContentView(), label: {
                            Text("Get Started ")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Capsule().fill(Color(hex: 0x3C6EE1)))
                        })
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear() {
            print("On Boarding Screen")
        }
    }
    func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentPage))
    }
    
    func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2 && currentPage < lastPage {
            currentPage += 1
        } else {
            if value.translation.width > screenWidth / 2 && currentPage > firstPage {
                currentPage -= 1
            }
        }
        withAnimation{
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

struct On_Boarding_Screen_Previews: PreviewProvider {
    static var previews: some View {
        On_Boarding_Screen()
    }
}

struct ItemView: View {
    var item: Item
    var imageBaseName: String
    @State var itemImage: String 
    
    
    var body: some View {
        ZStack {
            item.backgroundColor
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Image(itemImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 294, height: 243)
                    .padding(80)
                    .offset(y: 100)
                
                VStack(spacing: 15) {
                    Text(item.title)
                        .font(.system(size: 40, weight: .semibold))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    
                    Text(item.subtitle)
                        .font(.system(size: 25, weight: .regular))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                }
                .offset(y: 30)
                .padding(.horizontal)
                Spacer()
            }
            .foregroundColor(.black)
        }.onAppear(){
            if(item.animationCount > 0 ){
                timerImage()
            }
        }
    }
    
    func timerImage(){
        var index = 1
        let timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true){ Timer in
            
            itemImage = "\(imageBaseName)\(index)"
            
            index += 1
            
            if (index > item.animationCount ){
                index = 1
            }
            
            
        }
    }
}
