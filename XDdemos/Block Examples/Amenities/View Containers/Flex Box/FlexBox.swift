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
    typealias FlexSizes = SizePreferences<T>
    
    @State private var preferences: [T: CGRect] = [:]
    @State private var didFinishLayout = false
    
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
            ScrollView(.horizontal) {
                ZStack(alignment: .topLeading) {
                    ForEach(data, id: \.self) { item in
                        content(item)
                            .alignmentGuide(.leading) { _ in
                                -preferences[item, default: .zero].origin.x
                            }
                            .alignmentGuide(.top) { _ in
                                -preferences[item, default: .zero].origin.y
                            }
                            .anchorPreference(
                                key: FlexSizes.self,
                                value: .bounds
                            ) {
                                [item: geo[$0].size]
                            }
                    }
                }
                .onPreferenceChange(FlexSizes.self) { sizes in
                    if !didFinishLayout {
                        defer { self.didFinishLayout = true }
                        print("Size change")
                        sizePreferenceHandler(sizes, proxy: geo)
                    }
                }
            }
            
        }
    }
}


// MARK: - FlexBox Size Preferences Layouts
extension FlexBox {
    func sizePreferenceHandler(_ sizes: FlexSizes.Value, proxy: GeometryProxy) {
        switch direction {
            case .row, .rowReverse:
                flexRowSizeHandler(sizes, proxy: proxy)
                
            case .column, .columnReverse:
                flexColumnSizeHandler(sizes, proxy: proxy)
        }
    }
    
    func flexRowSizeHandler(_ sizes: FlexSizes.Value, proxy: GeometryProxy) {
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
    
    func flexColumnSizeHandler(_ sizes: FlexSizes.Value, proxy: GeometryProxy) {
        var newPrefs: [T: CGRect] = [:]
        var bounds: [CGRect] = []
        
        var totalCols = 0
        var leftColCount = 0
        var currColCount = 0
        
        for (index, item) in data.enumerated() {
            let size = sizes[item, default: .zero]
            let rect: CGRect
            
            if let lastBounds = bounds.last {
                var origin = CGPoint.zero
                
                if lastBounds.maxY + size.height > proxy.size.height {
                    leftColCount = currColCount
                    currColCount = 0
                    totalCols += 1
                    // origin = CGPoint(x: bounds[index - leftColCount - 1].maxX, y: .zero)
                    origin.x = bounds[index - leftColCount].maxX
                    
                } else {
                    
                    if totalCols == 0 {
                        origin.y = lastBounds.maxY
                    } else {
                        let leftI = index - leftColCount
                        let leftNeighbor = bounds[leftI]
                        
                        origin.x = leftNeighbor.maxX
                        origin.y = min(lastBounds.maxY, leftNeighbor.minY)
                    }
                }
                
                rect = CGRect(origin: origin, size: size)
                currColCount += 1
                
            } else {
                rect = CGRect(origin: .zero, size: size)
                currColCount += 1
            }
            
            bounds.append(rect)
            newPrefs[item] = rect
        }
        self.preferences = newPrefs
    }
}
