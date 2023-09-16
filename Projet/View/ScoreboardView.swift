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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(getScores()) { score in
                    ScoreView(score: score)
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
}
