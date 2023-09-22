//
//  ScoreboardView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import SwiftUI

//TODO faire en sorte que l'on puisse ajouter à la fin d'une partie gagnante
// Changer le nombre de mines affichées en fonction de la taille de l'écran

struct ScoreboardView: View {
    @ObservedObject private var scoreViewModel = ScoreViewModel()
    private let podiumColor: [Color] = [Color(red: 255, green: 215, blue: 0), Color(red: 192, green: 192, blue: 192), Color(red: 255, green: 87, blue: 51)]
    
    var body: some View {
        NavigationView {
            List {
                let scores = getScores()
                ForEach(0..<scores.count) { index in
                    ScoreView(score: scores[index])
                        .background(getColorFromIndex(index: index))
                }
            }
        }
        .navigationBarTitle("Tableau des scores")
    }
    
    func getScores() -> [Score] {
        let sortedScore = scoreViewModel.scores.sorted(by: { (lhs: Score, rhs: Score) -> Bool in
            return lhs.score < rhs.score
        })
        return sortedScore
    }
    
    func getColorFromIndex(index: Int) -> Color {
        if (index > podiumColor.count - 1) {
            print(index)
            return Color.white
        }
        print(podiumColor[index])
        return podiumColor[index]
    }
}
