//
//  Amenity.swift
//  XDdemos
//
//  Created by Dillon on 5/24/22.
//

import Foundation

struct Amenity: Identifiable {
    let id = UUID()
    let label: String
    let glyphName: String
}

struct Mock {
    static func amenities() -> [Amenity] {
        [
            Amenity(label: "Washer & Dryer", glyphName: "snowflake"),
            Amenity(label: "Fireplace", glyphName: "fireplace"),
            Amenity(label: "Kitchen", glyphName: "oven"),
            Amenity(label: "Hot tub", glyphName: "jacuzzi"),
            Amenity(label: "Beach view", glyphName: "umbrella"),
            Amenity(label: "Spa", glyphName: "lotus")
        ]
    }
}
