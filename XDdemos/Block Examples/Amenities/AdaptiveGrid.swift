//
//  AdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AdaptiveGrid<T, Content>: View where T: Hashable, Content: View {
    let data: [T]
    let direction: FlexDirection
    let size: FlexItemSize
    let gridContent: (T) -> Content
    
    init(
        _ data: [T],
        flexDirection: FlexDirection,
        itemSize: FlexItemSize = .defaultColumn,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.data = data
        self.direction = flexDirection
        self.size = itemSize
        self.gridContent = content
    }
    
    var body: some View {
        let gridItems = [GridItem(
            .adaptive(minimum: size.min, maximum: size.max),
            alignment: .leading
        )]
        
        switch direction {
            case .row, .rowReverse:
                // alignment of entire grid within parent view
                LazyHGrid(rows: gridItems, alignment: .center) {
                    FlexContent(data) { item in
                        gridContent(item)
                    }
                }
                
            case .column, .columnReverse:
                // alignment of entire grid within parent view
                LazyVGrid(columns: gridItems, alignment: .leading) {
                    FlexContent(data) { item in
                        gridContent(item)
                    }
                }
        }
    }
}


// MARK: Flex Content
struct FlexContent<T, Content>: View where T: Hashable, Content: View {
    let data: [T]
    let content: (T) -> Content
    
    init(_ data: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        ForEach(data, id: \.self) { item in
            content(item)
        }
    }
}


// MARK: - Helper Types
/// Based on ltr language (opposite for rtl?)
enum FlexDirection {
    case row // left --> right (default)
    case rowReverse // left <-- right
    case column // top --> bottom
    case columnReverse // top <-- bottom
}

struct FlexItemSize {
    let min: CGFloat
    let max: CGFloat
    
    static let defaultRow = FlexItemSize(min: 40, max: .infinity)
    static let defaultColumn = FlexItemSize(min: 192, max: .infinity)
    
    static func minimum(_ minSize: CGFloat) -> FlexItemSize {
        return FlexItemSize(min: minSize, max: .infinity)
    }
}


struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = Amenity.mock()
        
        AdaptiveGrid(
            amenities,
            flexDirection: .column,
            itemSize: .defaultColumn
        ) { amenity in
            AmenityItem(amenity)
        }
    }
}
