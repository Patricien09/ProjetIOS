//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var grid = MinesweeperGrid(mineRate: 0.12, width: 10, height: 16)
    @State private var startDate = Date()
    @State private var timeElapsed: String = "0.0"
    @State private var timer: Timer? = nil
    @State private var selectedDifficulty: Difficulty = .inter
    
    var body: some View {
        VStack {
            Text("\(timeElapsed)")
            
            Text("Mines restantes : \(grid.getNbMines())")
            
            DifficultyPickerView(selectedDifficulty: $selectedDifficulty)
            .onChange(of: selectedDifficulty) { test in
                self.resetGame()
                grid.setMineRate(newMineRate: selectedDifficulty.rawValue)
            }
            
            MinesweeperGridView()
                .environmentObject(grid)
                .onChange(of: grid.alreadyClicked) { isFirstClick in
                    if (isFirstClick) {
                        self.startTimer()
                    }
                }
            
            Button(action: resetGame) {
                Text("Recommencer")
            }
        }
    }
    
    func startTimer() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { tempTimer in
            timeElapsed = String(format: "%.1f", (Date().timeIntervalSince(startDate)))
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetGame() -> Void {
        grid.reset()
        timeElapsed = "0.0"
        self.stopTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
