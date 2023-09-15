//
//  VictoryView.swift
//  Projet
//
//  Created by Lucas Marchal on 9/15/23.
//

import SwiftUI

struct VictoryView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Vous avez gagné !"), message: Text("bla bla bli"), dismissButton: .default(Text("Oui ok")))
        }
    }
}
