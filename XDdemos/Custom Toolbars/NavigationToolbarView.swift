//
//  NavigationToolbarView.swift
//  XDdemos
//
//  Created by Dillon on 5/24/22.
//

import SwiftUI

struct NavigationToolbarView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var favorited: Bool = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        VStack {
            Color.blue
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            navigationToolbar
        }
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                ToolbarButton(sfSymbolName: "chevron.left") {
                    mode.wrappedValue.dismiss()
                }
            }
            
            ToolbarItem(placement: .principal) {
                toolbarTitleLabel
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarButton(
                    sfSymbolName: favorited ? "heart.fill" : "heart",
                    color: favorited ? .pink : .black
                ) {
                    favorited.toggle()
                }
            }
        }
    }
    
    var toolbarTitleLabel: some View {
        VStack {
            Text("Custom Title")
                .font(.custom("Avenir-Roman", size: 14, relativeTo: .title))
                .bold()
            
            Text("Subtitle")
                .font(.custom("Avenir-Light", size: 11, relativeTo: .subheadline))
        }
    }
}

struct ToolbarButton: View {
    var sfSymbolName: String
    var color: Color = .black
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: sfSymbolName)
                .symbolRenderingMode(.monochrome)
                .foregroundColor(color)
        }
    }
}

struct AtomicBlockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToolbarView()
    }
}
