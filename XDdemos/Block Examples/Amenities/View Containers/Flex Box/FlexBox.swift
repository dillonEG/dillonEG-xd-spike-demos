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
    let data: [T]
    let content: (T) -> Content
    
    init(_ data: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(data, id: \.self) { item in
                content(item)
            }
        }
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
