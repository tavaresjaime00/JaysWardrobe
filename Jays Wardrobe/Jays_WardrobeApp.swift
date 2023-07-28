//
//  Jays_WardrobeApp.swift
//  Jays Wardrobe
//
//  Created by Jaime Tavares on 2023-05-29.
//

import SwiftUI

@main
struct Jays_WardrobeApp: App {
    var body: some Scene {
        WindowGroup {
                ContentView()
            BannerContentView().padding(.top, 0).frame(height: CGFloat(UIDevice.current.hashValue.bitWidth)/2.0)

            //BannerContentView(navigationTitle: "Banner")
        }
    }
}
