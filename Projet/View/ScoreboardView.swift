//
//  ScoreboardView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import SwiftUI

struct ScoreboardView: View {
    @ObservedObject private var scoreViewModel = ScoreViewModel()
    private let podiumColor: [Color] = [Color(red: 1, green: 0.84, blue: 0), Color(red: 0.75, green: 0.75, blue: 0.75), Color(red: 0.7, green: 0.45, blue: 0.37)]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(getScores().enumerated()), id: \.offset) { index, element in
                    ScoreView(score: element)
                        .background(getColorFromIndex(index: index))
                }
            }
            .onAppear {
                scoreViewModel.fetchScores()
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
