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
    private let url: String = "https://650564b3ef808d3c66effbfc.mockapi.io/scoreboard/v1"
    
    init() {
        fetchScores()
    }
    
    func fetchScores() {
        AF.request("\(url)/score").response { response in
            if let data = response.data {
                self.scores = try! JSONDecoder().decode([Score].self, from: data)
            }
        }
    }
    
    
    
    func sendScore(name: String, time: Float, completion: @escaping (AFResult<String>) -> Void) -> Void {
        let params: Parameters = [
            "score": time,
            "name": name
        ]
        
        AF.request("\(url)/score", method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success("nil"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
