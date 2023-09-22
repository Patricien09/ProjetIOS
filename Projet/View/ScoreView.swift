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
        VStack(alignment: .center, spacing: 6) {
            let scoreTime = secondToHoursMinutesSecondsMili(score.score)
            Text("\(score.name) le \(formatDate(unixDate: score.createdAt))")
            Text("\(scoreTime.0)h:\(scoreTime.1)m:\(scoreTime.2)s:\(scoreTime.3)ms")
        }
            .frame(maxWidth: .infinity)
    }
    
    func formatDate(unixDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/y"
        return dateFormatter.string(from: date)
    }
    
    func secondToHoursMinutesSecondsMili(_ seconds: Float) -> (Int, Int, Int, Int) {
        return (Int(seconds) / 3600, (Int(seconds) % 3600) / 60, (Int(seconds) % 3600) % 60, Int(seconds.truncatingRemainder(dividingBy: 1) * 1000))
    }
}
