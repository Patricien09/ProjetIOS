//
//  ProjetApp.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

@main
struct ProjetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MinesweeperGrid(mineRate: 0.2, width: 10, height: 10))
        }
    }
}
