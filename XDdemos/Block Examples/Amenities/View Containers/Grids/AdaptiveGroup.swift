//
//  AdaptiveGroup.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AdaptiveGroup<T, Content>: View where T: Hashable, Content: View {
    let data: [T]
    let direction: FlexDirection
    let size: AdaptiveItemSize
    let groupContent: (T) -> Content
    
    init(
        _ data: [T],
        flexDirection: FlexDirection,
        itemSize: AdaptiveItemSize = .defaultColumn,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.data = data
        self.direction = flexDirection
        self.size = itemSize
        self.groupContent = content
    }
    
    var body: some View {
        let gridItems = [
            GridItem(
                .adaptive(minimum: size.min, maximum: size.max),
                alignment: .leading
            )
        ]
        
        switch direction {
            case .row, .rowReverse:
                // alignment of entire grid within parent view
                LazyHGrid(rows: gridItems, alignment: .center) {
                    AdaptiveContent(data, direction) { item in
                        groupContent(item)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                
            case .column, .columnReverse:
                // alignment of entire grid within parent view
                LazyVGrid(columns: gridItems, alignment: .leading) {
                    AdaptiveContent(data, direction) { item in
                        groupContent(item)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    }
                }
        }
    }
}

// MARK: Adaptive Content
struct AdaptiveContent<T, Content>: View where T: Hashable, Content: View {
    let data: [T]
    let direction: FlexDirection
    let content: (T) -> Content
    
    init(_ data: [T], _ direction: FlexDirection, @ViewBuilder content: @escaping (T) -> Content) {
        self.data = AdaptiveContent.isReverse(direction) ? data.reversed() : data
        self.direction = direction
        self.content = content
    }
    
    var body: some View {
        ForEach(data, id: \.self) { item in
            content(item)
        }
    }
    
    static func isReverse(_ direction: FlexDirection) -> Bool {
        return direction == .rowReverse || direction == .columnReverse
    }
}


struct AdaptiveGrid_Previews: PreviewProvider {
    static var previews: some View {
        let amenities: [Amenity] = Amenity.mock()
        
        AdaptiveGroup(
            amenities,
            flexDirection: .column,
            itemSize: .defaultColumn
        ) { amenity in
            AmenityItem(amenity)
        }
    }
}
