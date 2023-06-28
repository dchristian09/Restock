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
    let animationCount: Int
}

let data = [
    Item(backgroundColor: Color("color"),
         image: "material_gif-",
         title: "Material",
         subtitle: "Easily track and manage your \r\n raw material inventory for \r\n a smooth production process.",
         animationCount: 13),
    Item(backgroundColor: Color("color"),
         image: "product_gif-",
         title: "Product",
         subtitle: "Monitor and manage your \r\n diverse product effortlessly.",
         animationCount: 27),
    Item(backgroundColor: Color("color"),
         image: "production_gif-",
         title: "Production",
         subtitle: "Take control of your \r\n production process by tracking \r\n inventory stock with ease and precision.",
         animationCount: 27),
    Item(backgroundColor: Color("color"),
         image: "summary_gif-",
         title: "Summary",
         subtitle: "Streamline your business operations \r\n with our inventory reminder feature. \r\n Keep a close eye on stock levels and \r\n receive alerts for low quantities.",
         animationCount: 35)
]
