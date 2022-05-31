//
//  FlexBox.swift
//  XDdemos
//
//  Created by Dillon on 5/30/22.
//

import SwiftUI

struct SizePreferences<Item: Hashable>: PreferenceKey {
    typealias Value = [Item: CGSize]
    static var defaultValue: Value { [:] }
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue()) { $1 }
    }
}

struct FlexBox<T: Hashable, Content>: View where Content: View {
    @State private var preferences: [T: CGRect] = [:]
    let data: [T]
    let direction: FlexDirection
    let content: (T) -> Content
    
    init(
        _ data: [T],
        flexDirection: FlexDirection = .row,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.data = data
        self.direction = flexDirection
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(data, id: \.self) { item in
                    content(item)
                        .padding(8) // padding around inner content to edge of cell
                        .alignmentGuide(.leading) { _ in
                            -preferences[item, default: .zero].origin.x
                        }
                        .alignmentGuide(.top) { _ in
                            -preferences[item, default: .zero].origin.y
                        }
                        .anchorPreference(
                            key: SizePreferences<T>.self,
                            value: .bounds
                        ) {
                            [item: geo[$0].size]
                        }
                }
            }
            .onPreferenceChange(SizePreferences<T>.self) { sizes in
                sizePreferenceHandler(sizes, proxy: geo)
            }
        }
    }
    
    
    func sizePreferenceHandler(_ sizes: SizePreferences<T>.Value, proxy: GeometryProxy) {
        var newPrefs: [T: CGRect] = [:]
        var bounds: [CGRect] = []
        
        for item in data {
            let size = sizes[item, default: .zero]
            let rect: CGRect
            
            if let lastBounds = bounds.last {
                if lastBounds.maxX + size.width > proxy.size.width {
                    let origin = CGPoint(x: 0, y: lastBounds.maxY)
                    rect = CGRect(origin: origin, size: size)
                    
                } else {
                    let origin = CGPoint(x: lastBounds.maxX, y: lastBounds.minY)
                    rect = CGRect(origin: origin, size: size)
                }
                
            } else {
                rect = CGRect(origin: .zero, size: size)
            }
            bounds.append(rect)
            newPrefs[item] = rect
        }
        self.preferences = newPrefs
    }
}


struct FlexBox_Previews: PreviewProvider {
    static var previews: some View {
        let amenities: [Amenity] = Amenity.mock()
        
        FlexBox(amenities) { item in
            AmenityItem(item)
                .fixedSize()
                .background(.orange)
        }
    }
}
