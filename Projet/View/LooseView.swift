//
//  VictoryView.swift
//  Projet
//
//  Created by Lucas Marchal on 9/15/23.
//

import SwiftUI

struct LooseView: View {
    var body: some View {
        VStack {
            Text("Défaite 🥶")
                .font(.headline)
            Text("Réessayez en changeant de difficulté si c'est trop dur pour vous")
                .padding()
                .multilineTextAlignment(.center)
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(30)
    }
}
