//
//  AdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AdaptiveGrid<Content>: View where Content: View {
    let flexDirection: FlexDirection
    let minItemSize: CGFloat
    let gridContent: Content
    
    init(flexDirection: FlexDirection, minItemSize: CGFloat, @ViewBuilder content: () -> Content) {
        self.flexDirection = flexDirection
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

/// Based on ltr language (opposite for rtl?)
enum FlexDirection {
    case row // left --> right (default)
    case rowReverse // left <-- right
    case column // top --> bottom
    case columnReverse // top <-- bottom
}

struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = Amenity.mock()
        
        AdaptiveGrid(flexDirection: .column, minItemSize: 190, content: {
            ForEach(amenities) { amenity in
                AmenityItem(amenity)
            }
        })
    }
}
