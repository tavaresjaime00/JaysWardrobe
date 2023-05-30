//
//  ContentView.swift
//  Jays Wardrobe
//
//  Created by Jaime Tavares on 2023-05-29.
//


import SwiftUI

struct SectionTitleView: View {
    let text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.bold)
            .padding([.top, .horizontal])
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(text: "Hello")
            .previewLayout(.sizeThatFits)
    }
}
