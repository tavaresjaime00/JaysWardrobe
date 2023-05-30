//
//  ContentView.swift
//  Jays Wardrobe
//
//  Created by Jaime Tavares on 2023-05-29.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    private var allShirts: [FavoriteWrapper<Shirt>] = []
    @Published private(set) var shirts: [Shirt] = []
    @Published private(set) var recommendations: [Shirt] = []
    
    private var recommendationsTask: Task<Void, Never>?
    
    private let recommendationStore: RecommendationStore
    
    init(recommendationStore: RecommendationStore = RecommendationStore()) {
        self.recommendationStore = recommendationStore
    }
    
    func loadAllShirts() async {
        guard let url = Bundle.main.url(forResource: "shirts", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            allShirts = (try JSONDecoder().decode([Shirt].self, from: data)).shuffled().map {
                FavoriteWrapper(model: $0)
            }
            shirts = allShirts.map(\.model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func didRemove(_ item: Shirt, isLiked: Bool) {
        shirts.removeAll { $0.id == item.id }
        if let index = allShirts.firstIndex(where: { $0.model.id == item.id }) {
            allShirts[index] = FavoriteWrapper(model: item, isFavorite: isLiked)
        }
        
        recommendationsTask?.cancel()
        recommendationsTask = Task {
            do {
                let result = try await recommendationStore.computeRecommendations(basedOn: allShirts)
                if !Task.isCancelled {
                    recommendations = result
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func resetUserChoices() {
        shirts = allShirts.map(\.model)
        recommendations = []
    }
}
