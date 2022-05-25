//
//  NavigationToolbarView.swift
//  EGFlexBox
//
//  Created by Dillon on 5/24/22.
//

import SwiftUI

struct NavigationToolbarView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .blue
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Color.blue
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Custom Title")
                            .font(.custom("Avenir-Roman", size: 14, relativeTo: .title))
                            .bold()
                        
                        Text("Subtitle")
                            .font(.custom("Avenir-Light", size: 11, relativeTo: .subheadline))
                    }
                }
            }
        }
    }
}

struct AtomicBlockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToolbarView()
    }
}
