//
//  Item.swift
//  Restock
//
//  Created by Oey Darryl Valencio Wijaya on 25/06/23.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID().uuidString
    let backgroundColor: Color
    let image: String
    let title: String
    let subtitle: String
}

let data = [
    
    Item(backgroundColor: Color("color"), image: "material_on_boarding_screen", title: "Material", subtitle: "Input & track your material"),
    Item(backgroundColor: Color("color"), image: "product_on_boarding_screen", title: "Product", subtitle: "Input & track your product"),
    Item(backgroundColor: Color("color"), image: "production_on_boarding_screen", title: "Production", subtitle: "Produce or reduce your stock"),
    Item(backgroundColor: Color("color"), image: "summary_on_boarding_screen", title: "Summary", subtitle: "Get your stock reminder")
]
