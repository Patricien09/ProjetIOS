//
//  ScoreViewModel.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import Foundation
import Alamofire
import Combine

class ScoreViewModel: ObservableObject {
    @Published var scores: [Score] = [Score]()
    
    init() {
        getScores()
    }
    
    func getScores() {
        AF.request("https://650564b3ef808d3c66effbfc.mockapi.io/scoreboard/v1/score").response { response in
            self.scores = try! JSONDecoder().decode([Score].self, from: response.data!)
        }
    }
}
