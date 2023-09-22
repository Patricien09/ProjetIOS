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
        VStack {
            let scoreTime = secondToHoursMinutesSeconds(Int(score.score))
            Text("\(score.name) le \(formatDate(unixDate: score.createdAt))")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(scoreTime.0)h:\(scoreTime.1)m:\(scoreTime.2)s")
        }
    }
    
    func formatDate(unixDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/y"
        return dateFormatter.string(from: date)
    }
    
    func secondToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
