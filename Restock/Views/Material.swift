//
//  Material.swift
//  Restock
//
//  Created by David Christian on 13/06/23.
//

import SwiftUI
import PhotosUI

struct Material: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    var body: some View {
        VStack{
            if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()
                    .frame(width: 300, height: 300)
            }
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            ){
                Text("Pick Photo")
            }
            .onChange(of: selectedItems){ newValue in
                guard let item = selectedItems.first else{
                    return
                }
                item.loadTransferable(type: Data.self){result in
                    switch result{
                    case.success(let data):
                        if let data = data {
                            self.data = data
                        }else{
                            print("Data is nil")
                        }
                    case.failure(let failure):
                        fatalError("\(failure)")
                    }
                }
            }
        }
        
    }
}

struct Material_Previews: PreviewProvider {
    static var previews: some View {
        Material()
    }
}
