//
//  DifficultyPicker.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import SwiftUI

enum Difficulty: Float, Identifiable {
    case easy = 0.01
    case inter = 0.17
    case hard = 0.34
    var id: Self { self }
}

struct DifficultyPickerView: View {
    @Binding var selectedDifficulty: Difficulty
    
    var body: some View {
        Picker("Difficulté", selection: $selectedDifficulty) {
            Text("Facile").tag(Difficulty.easy)
            Text("Intermédiaire").tag(Difficulty.inter)
            Text("Difficile").tag(Difficulty.hard)
        }
    }
}
