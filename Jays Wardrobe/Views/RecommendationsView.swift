//
//  ContentView.swift
//  Jays Wardrobe
//
//  Created by Jaime Tavares on 2023-05-29.
//


import SwiftUI

struct RecommendationsView<Model>: View where Model: TextImageProviding & Hashable & Identifiable {
    let recommendations: [Model]
    
    var body: some View {
        Spacer()
        VStack(alignment: .leading, spacing: 8) {
            SectionTitleView(text: "Your Personalized Wardrobe")
            
            Text("As you swipe, we'll update our recommendations to better suit you")
                .font(.system(size: 20.0, weight: .regular, design: .rounded).italic())
                .padding(.leading, 16.0)
            
            if !recommendations.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 12.0) {
                        ForEach(recommendations) { item in
                            SmallCardView(model: item)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                HStack {
                    Spacer()
                    
                    VStack {
                        Image(systemName: "tshirt.fill")
                            .imageScale(.large)
                            .font(.title3)
                        Text("Nothing just yet. Start swiping to get personalized options!")
                            .multilineTextAlignment(.center)
                            .font(.callout)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 64)
            }
        }
        .foregroundColor(Color("secondary"))
    }
}

struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsView(
            recommendations: [Shirt.black]
        )
        .previewLayout(.fixed(width: 400.0, height: 220.0))
    }
}
