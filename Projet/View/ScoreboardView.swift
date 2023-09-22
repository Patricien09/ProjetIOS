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
    private let podiumColor: [Color] = [Color(red: 1.0, green: 0.84, blue: 0), Color(red: 0.75, green: 0.75, blue: 0.75), Color(red: 0.7, green: 0.45, blue: 0.37)]
    
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
            return Color.white
        }
        return podiumColor[index]
    }
}
