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
            NavigationView {
                ZStack {
                    Image("BGMinesweeper")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        NavigationLink(
                            destination: GameView(),
                            label: {
                                Text("Nouvelle partie")
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.5)
                                    .padding()
                            }
                        )
                        .background(Color.gray)
                        .cornerRadius(10.0)
                        
                        NavigationLink(
                            destination: ScoreboardView(),
                            label: {
                                Text("Tableau des scores")
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.5)
                                    .padding()
                            }
                        )
                        .background(Color.gray)
                        .cornerRadius(10.0)
                    }
                }
            }
        }
    }
}
