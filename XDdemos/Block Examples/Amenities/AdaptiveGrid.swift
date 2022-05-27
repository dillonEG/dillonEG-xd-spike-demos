//
//  AdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AdaptiveGrid<Content>: View where Content: View {
    typealias ItemSize = (min: CGFloat, max: CGFloat)
    let direction: FlexDirection
    let size: FlexSize
    let gridContent: Content
    
    init(
        flexDirection: FlexDirection,
        itemSize: FlexSize = .defaultColumn,
        @ViewBuilder content: () -> Content
    ) {
        self.direction = flexDirection
        self.size = itemSize
        self.gridContent = content()
    }
    
    var body: some View {
        let gridItems = [GridItem(
            .adaptive(minimum: size.min, maximum: size.max),
            alignment: .leading
        )]
        
        switch direction {
            case .row, .rowReverse:
                // alignment of grid within parent view
                LazyHGrid(rows: gridItems) {
                    gridContent
                }
                
            case .column, .columnReverse:
                // alignment of grid within parent view
                LazyVGrid(columns: gridItems) {
                    gridContent
                }
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

struct FlexSize {
    let min: CGFloat
    let max: CGFloat
    
    static let defaultRow = FlexSize(min: 40, max: .infinity)
    static let defaultColumn = FlexSize(min: 190, max: .infinity)
}


struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = Amenity.mock()
        
        AdaptiveGrid(
            ForEach(amenities) { amenity in
            flexDirection: .column,
            itemSize: .defaultColumn
        ) { amenity in
            AmenityItem(amenity)
        }
    }
}
