//
//  ScoreView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import SwiftUI

struct ScoreView: View {
    @State var score: Score
    
    var body: some View {
        HStack {
            Text("\(score.name) le \(formatDate(unixDate: score.createdAt)) : fini en \(score.score) secondes")
        }
    }
    
    func formatDate(unixDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/y"
        return dateFormatter.string(from: date)
    }
}
