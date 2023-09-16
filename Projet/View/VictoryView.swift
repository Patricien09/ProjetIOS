//
//  VictoryView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import SwiftUI

struct VictoryView: View {
    @State var time: String
    
    var body: some View {
        VStack {
            Text("Victoire ! 👍")
                .padding()
                .font(.headline)
            RandomMemeView()
            Text("Vous avez battu le démineur en \(time) secondes")
                .padding()
                .multilineTextAlignment(.center)
//            TextField("Rentrez votre nom pour l'enregistrer de le tableau des scores")
        }
        .frame(width: 300, height: 500)
        .background(Color.white)
        .cornerRadius(30)
    }
}
