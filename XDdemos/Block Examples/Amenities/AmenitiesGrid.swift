//
//  AdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AdaptiveGrid<Content>: View where Content: View {
    let minItemSize: CGFloat
    let gridContent: Content
    
    init(minItemSize: CGFloat, @ViewBuilder content: () -> Content) {
        self.minItemSize = minItemSize
        self.gridContent = content()
    }
    
    var body: some View {
        let cell = GridItem(.adaptive(minimum: minItemSize))

        LazyVGrid(columns: [cell], alignment: .leading) {
            gridContent
        }
    }
}

struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = Amenity.mock()
        
        AdaptiveGrid(minItemSize: 190, content: {
            ForEach(amenities) { amenity in
                AmenityItem(amenity)
            }
        })
    }
}
