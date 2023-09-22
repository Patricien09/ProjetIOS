//
//  SendScoreView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/22/23.
//

import SwiftUI

struct SendScoreView: View {
    @State var name: String = ""
    @State var time: String
    @State var isSend: Bool = false
    @ObservedObject private var scoreViewModel = ScoreViewModel()
    
    var body: some View {
        VStack {
            TextField("Rentrez votre nom pour l'enregistrer de le tableau des scores", text: $name)
                .multilineTextAlignment(.center)
                .border(.black, width: 1)
                .padding()
            Button(isSend ? "C'est tout bon" : "Envoyer", action: sendScore)
                .padding()
                .disabled(isSend)
        }
    }
    
    func sendScore() -> Void {
        scoreViewModel.sendScore(name: name, time: Float(time)!) { result in
            switch result {
            case .success:
                isSend = true
            case .failure:
                return
            }
        }
    }
}
