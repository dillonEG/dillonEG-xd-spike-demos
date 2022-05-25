//
//  NavigationToolbarView.swift
//  EGFlexBox
//
//  Created by Dillon on 5/24/22.
//

import SwiftUI

struct NavigationToolbarView: View {
    @State private var favorite: Bool = false
    
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
                navigationToolbar
            }
        }
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    print("Back button tapped")
                } label: {
                    sfSymbol(name: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Custom Title")
                        .font(.custom("Avenir-Roman", size: 14, relativeTo: .title))
                        .bold()
                    
                    Text("Subtitle")
                        .font(.custom("Avenir-Light", size: 11, relativeTo: .subheadline))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favorite.toggle()
                } label: {
                    sfSymbol(
                        name: favorite ? "heart.fill" : "heart",
                        color: favorite ? .pink : .black
                    )
                }
            }
        }
    }
    
    func sfSymbol(name: String, color: Color = .black) -> some View {
        Image(systemName: name)
            .symbolRenderingMode(.monochrome)
            .foregroundColor(color)
    }
}

struct AtomicBlockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToolbarView()
    }
}
