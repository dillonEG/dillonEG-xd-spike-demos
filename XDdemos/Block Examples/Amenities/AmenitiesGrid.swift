//
//  AdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AmenitiesGrid: View {
    let amenities: [Amenity] = Amenity.mock()
    let minWidth: CGFloat

    var body: some View {
        let cell = GridItem(.adaptive(minimum: minWidth))

        LazyVGrid(columns: [cell], alignment: .leading) {
            ForEach(amenities, id: \.self) { amenity in
                AmenityItem(amenity)
            }
        }
    }
}

struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesGrid(minWidth: 190)
            .previewDevice("iPhone 8 Plus")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
