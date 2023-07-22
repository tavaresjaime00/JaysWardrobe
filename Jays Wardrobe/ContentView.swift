//
//  ContentView.swift
//  Jays Wardrobe
//
//  Created by Jaime Tavares on 2023-05-29.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MainViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: MainViewModel())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 20.0) {
                        Text("Jay's Wardrobe")
                            .font(.system(size: 35.0, weight: .bold, design: .rounded))
                            .foregroundColor(Color("secondary"))
                            .padding(10)
                        Image("logo").resizable().frame(width: 150.0, height: 150.0)
                    }
                    
                    SectionTitleView(text: "Swipe to Like or Dislike").foregroundColor(Color("secondary"))
                    
                    if viewModel.shirts.isEmpty {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("All Done!")
                                    .multilineTextAlignment(.center)
                                    .font(.callout)
                                    .foregroundColor(.white)
                                Button("Try Again") {
                                    withAnimation {
                                        viewModel.resetUserChoices()
                                    }
                                }
                                .font(.headline)
                                .buttonStyle(.borderedProminent)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 32)
                    } else {
                        CardsStackView(models: viewModel.shirts) { item, isLiked in
                            withAnimation(.spring()) {
                                viewModel.didRemove(item, isLiked: isLiked)
                            }
                        }
                        .zIndex(1)
                    }
                    Spacer()
                    RecommendationsView(recommendations: viewModel.recommendations)
                }
                //Spacer()
                BannerContentView()
                
            }
            .task {
                await viewModel.loadAllShirts()
            }
            .background(Color("background"))
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
